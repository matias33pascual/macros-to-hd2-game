import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/home_page/providers/exports_providers.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

class ConnectionService {
  ConnectionService._();
  static final ConnectionService _instance = ConnectionService._();
  static ConnectionService get instance => _instance;

  IOWebSocketChannel? channel;
  Timer? _timeoutTimer;
  Completer<bool>? _connectionCompleter;

  Future<bool> connectToServer(
    String ip,
    String port,
    BuildContext context,
  ) async {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );

    homeProvider.setIsLoading(true);
    homeProvider.setMessageError(false);

    try {
      if (channel == null) {
        _connectionCompleter = Completer<bool>();

        channel = IOWebSocketChannel.connect(
          "ws://$ip:$port",
          connectTimeout: const Duration(seconds: 5),
        );

        channel!.stream.listen(
          (message) async {
            final jsonMessage = jsonDecode(message)["message"];

            if (jsonMessage == "macros-to-helldivers-pc") {
              if (!_connectionCompleter!.isCompleted) {
                _connectionCompleter!.complete(true);
              }

              await homeProvider
                  .saveConnectionDataToLocalStorage(ip, port)
                  .then((_) => homeProvider.setIsLoading(false));

              if (kDebugMode) {
                print("Conexion establecida en $ip:$port");
              }
            }
          },
          onError: (error) {
            if (!_connectionCompleter!.isCompleted) {
              _connectionCompleter!.complete(false);
            }
            if (kDebugMode) {
              print("Error en ConnectionService.connectToServer: $error");
            }

            homeProvider.setIsLoading(false);

            disconnect();
          },
          onDone: () {
            if (!_connectionCompleter!.isCompleted) {
              _connectionCompleter!.complete(false);
            }

            homeProvider.setIsLoading(false);

            disconnect();
          },
        );

        return _connectionCompleter!.future;
      } else {
        if (kDebugMode) {
          print("Se intento conectar al servidor pero la conexion ya habia sido realizada.");
        }

        homeProvider.setIsLoading(false);

        return Future.value(true);
      }
    } on SocketException catch (_) {
      if (kDebugMode) {
        print("Error en ConnectionService.connectToServer: SocketException");
      }

      channel = null;

      homeProvider.setIsLoading(false);

      return Future.value(false);
    } catch (error) {
      if (kDebugMode) {
        print("Error en ConnectionService.connectToServer: $error");
      }

      channel = null;

      homeProvider.setIsLoading(false);

      return Future.value(false);
    }
  }

  sendMessage({String message = ""}) {
    channel?.sink.add(message);
  }

  void disconnect() {
    if (channel != null) {
      channel!.sink.close();

      channel = null;

      if (kDebugMode) {
        print("Conexion cerrada");
      }
    }
    _timeoutTimer?.cancel();
  }
}

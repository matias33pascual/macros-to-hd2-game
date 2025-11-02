import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/home_page/providers/connect_button_provider.dart';
import 'package:macros_to_helldivers/home_page/states/home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  HomeState state = HomeState.instance;

  final ConnectButtonProvider connectButtonProvider;

  HomeProvider({required this.connectButtonProvider});

  void setIsLoading(bool value) {
    state.isLoading = value;

    connectButtonProvider.notifyListeners();

    notifyListeners();
  }

  void setIPAddress(String value) {
    state.ipAddrress = value;

    connectButtonProvider.notifyListeners();
  }

  void setPort(String value) {
    state.port = value;

    connectButtonProvider.notifyListeners();
  }

  void setMessageError(bool value) {
    state.error = value;
    notifyListeners();
  }

  Future<void> saveConnectionDataToLocalStorage(String ip, String port) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      "connection-data",
      jsonEncode({"ip": ip, "port": port}),
    );
  }

  Future<void> loadDataFromLocalStorate(BuildContext context) async {
    await SharedPreferences.getInstance().then(
      (prefs) {
        String? value = prefs.getString("connection-data");

        if (value != null) {
          final data = jsonDecode(value);

          state.ipAddrress = data["ip"];
          state.port = data["port"];

          connectButtonProvider.notifyListeners();

          notifyListeners();
        }
      },
    );
  }
}

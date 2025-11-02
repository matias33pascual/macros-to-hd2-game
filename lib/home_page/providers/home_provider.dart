import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/home_page/providers/connect_button_provider.dart';
import 'package:macros_to_helldivers/home_page/states/home_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  HomeState state = HomeState.instance;

  void setIsLoading(bool value, BuildContext context) {
    state.isLoading = value;

    final ConnectButtonProvider connectButtonProvider = Provider.of<ConnectButtonProvider>(context, listen: false);

    connectButtonProvider.notifyListeners();

    notifyListeners();
  }

  void setIPAddress(String value, BuildContext context) {
    state.ipAddrress = value;

    final ConnectButtonProvider connectButtonProvider = Provider.of<ConnectButtonProvider>(context, listen: false);

    connectButtonProvider.notifyListeners();
  }

  void setPort(String value, BuildContext context) {
    state.port = value;

    final ConnectButtonProvider connectButtonProvider = Provider.of<ConnectButtonProvider>(context, listen: false);

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
    final ConnectButtonProvider connectButtonProvider = Provider.of<ConnectButtonProvider>(context, listen: false);

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

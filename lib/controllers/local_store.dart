import 'package:shared_preferences/shared_preferences.dart';

import 'package:tapp/utils/web.dart';
import 'package:tapp/variables/local_variables.dart';
import 'package:uuid/uuid.dart';

void initPrefs(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey(gameCoinsLabel)) {
    gameCoins = prefs.getInt(gameCoinsLabel)!;
    deviceId = prefs.getString(deviceIdLabel)!;
    // late DateTime lastCompletion;
    mainTasks();
  } else {
    mainTasks();

    prefs.setString(deviceIdLabel, const Uuid().v4());
    deviceId = prefs.getString(deviceIdLabel)!;

    // sendDeviceIdToBackend(deviceId, gameCoins.toString());

    prefs.setInt(gameCoinsLabel, 0);

    gameCoins = 0;

    // prefs.getKeys();
  }
  // Navigator.popAndPushNamed(context, "/login");
}

Future<int> increaseGameCoin(int value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if ((gameCoins + value) >= 19000) {
    prefs.setInt(gameCoinsLabel, prefs.getInt(gameCoinsLabel)! + 1);
    gameCoins = prefs.getInt(gameCoinsLabel)!;
  } else {
    prefs.setInt(gameCoinsLabel, prefs.getInt(gameCoinsLabel)! + value);
    gameCoins = prefs.getInt(gameCoinsLabel)!;
  }

  return gameCoins;
}

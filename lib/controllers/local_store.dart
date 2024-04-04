import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapp/variables/local_variables.dart';
import 'package:uuid/uuid.dart';

void initPrefs(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey(gameCoinsLabel)) {
    gameCoins = prefs.getInt(gameCoinsLabel)!;
    deviceId = prefs.getString(deviceIdLabel)!;
    late DateTime lastCompletion;
    if (gameCoins < 12000) {
      phase = prefs.getInt('phase1')!;
    }
    if (gameCoins >= 12000 && gameCoins < 15000) {
      lastCompletion = DateTime.fromMillisecondsSinceEpoch(
          prefs.getInt('12000Coin-Completiontime') ?? 0);

      DateTime now = DateTime.now();
      Duration difference = now.difference(lastCompletion);
      if (difference.inHours >= 24) {
        phase = prefs.getInt('phase2')!;
      } else {
        phase = prefs.getInt('phase1')!;
      }
    }
    if (gameCoins >= 15000 && gameCoins < 18000) {
      lastCompletion = DateTime.fromMillisecondsSinceEpoch(
          prefs.getInt('15000Coin-Completiontime') ?? 0);

      DateTime now = DateTime.now();
      Duration difference = now.difference(lastCompletion);
      if (difference.inHours >= 24) {
        phase = prefs.getInt('phase3')!;
      } else {
        phase = prefs.getInt('phase2')!;
      }
    }
    if (gameCoins >= 18000 && gameCoins < 20000) {
      lastCompletion = DateTime.fromMillisecondsSinceEpoch(
          prefs.getInt('18000Coin-Completiontime') ?? 0);

      DateTime now = DateTime.now();
      Duration difference = now.difference(lastCompletion);
      if (difference.inHours >= 24) {
        phase = prefs.getInt('phase4')!;
      } else {
        phase = prefs.getInt('phase3')!;
      }
    }
  } else {
    prefs.setString(deviceIdLabel, const Uuid().v4());
    deviceId = prefs.getString(deviceIdLabel)!;

    // sendDeviceIdToBackend(deviceId, gameCoins.toString());

    prefs.setInt(gameCoinsLabel, 0);
    prefs.setInt('phase1', 12000);
    prefs.setInt('phase2', 15000);
    prefs.setInt('phase3', 18000);
    prefs.setInt('phase4', 20000);

    gameCoins = 0;
    phase = prefs.getInt('phase1')!;
    // prefs.getKeys();
  }
  Navigator.popAndPushNamed(context, "/gamehome");
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

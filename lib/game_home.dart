import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapp/utils/web.dart';
import 'package:tapp/variables/local_variables.dart';
import 'package:tapp/variables/modal_variable.dart';
import 'package:tapp/widgets/commonboxnew.dart';
import 'package:tapp/widgets/commonmincoinbar.dart';
import 'package:tapp/widgets/commontop.dart';

class GameHome extends StatefulWidget {
  const GameHome({super.key});

  @override
  State<GameHome> createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> {
  late SharedPreferences _prefs;
  String deviceIdK = 'N/A';

  @override
  void initState() {
    super.initState();

    getdeviceId();
    updateCoins(deviceId, gameCoins.toString());
    if (phase != 0 && gameCoins >= phase) {
      _initializeSharedPreferences();
    }
  }

  Future<void> getdeviceId() async {
    var prefs = await SharedPreferences.getInstance();
    deviceId = prefs.getString(deviceIdLabel)!;
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    // print(phase);

    if (DateTime.fromMillisecondsSinceEpoch(
                    _prefs.getInt('${phase}Coin-Completiontime') ?? 0)
                .toString() !=
            '' &&
        DateTime.fromMillisecondsSinceEpoch(
                    _prefs.getInt('${phase}Coin-Completiontime') ?? 0)
                .toString() ==
            '1970-01-01 05:30:00.000') {
      _prefs.setInt(
          '${phase}Coin-Completiontime', DateTime.now().millisecondsSinceEpoch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Commontop(),
                const SizedBox(
                  height: 16,
                ),
                CommonMinCoinBar(
                  text1: otherLinksModel.otherlinks![7].link,
                  text2: otherLinksModel.otherlinks![8].link,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonBoxNew(
                      text: 'CLICK',
                      route: '/click',
                      fontSize: 45.0,
                    ),
                    CommonBoxNew(
                      text: 'TASK',
                      route: '/task',
                      fontSize: 40.0,
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonBoxNew(
                      text: 'NOTIFIC \n ATIONS',
                      route: '/bonus',
                      fontSize: 25.0,
                    ),
                    CommonBoxNew(
                      text: 'PROFILE',
                      route: '/profile',
                      fontSize: 25.0,
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonBoxNew(
                      text: 'LOGIN',
                      route: '/login',
                      fontSize: 25.0,
                    ),
                    CommonBoxNew(
                      text: 'Register',
                      route: '/register',
                      fontSize: 25.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

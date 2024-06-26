import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapp/pendingtask_screen.dart';
import 'package:tapp/utils/web.dart';
import 'package:tapp/variables/local_variables.dart';
import 'package:tapp/variables/modal_variable.dart';

import 'package:tapp/widgets/commonboxnew.dart';
import 'package:tapp/widgets/commonmincoinbar.dart';
import 'package:tapp/widgets/commontop.dart';
import 'package:tapp/widgets/notificationmark.dart';

class GameHome extends StatefulWidget {
  const GameHome({super.key});

  @override
  State<GameHome> createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> {
  late SharedPreferences _prefs;
  String deviceIdK = 'N/A';
  String uid = '';

  @override
  void initState() {
    super.initState();

    // getdeviceId();
    testFun();
    gameHomeMainTasks();
    testFun();
    testFunCoin();
    testFun();

    updateCoins(deviceId, gameCoins.toString());
    if (phase != 0 && gameCoins >= phase) {
      // _initializeSharedPreferences();
    }
  }

  Future<void> testFun() async {
    var prefs = await SharedPreferences.getInstance();
    print(prefs.getKeys());
    // setState(() {
    //   uid = prefs.getString('uId')!;
    // });
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
                // CommonMinCoinBar(
                //   text1: otherLinksModel.otherlinks![7].link,
                //   text2: otherLinksModel.otherlinks![8].link,
                // ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      logout(context);
                    },
                    child: const Text('Logout')),
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
                    Stack(
                      children: [
                        CommonBoxNew(
                          text: 'NOTIFIC \n ATIONS',
                          route: '/profile',
                          fontSize: 25.0,
                        ),
                        NotificationMark(),
                      ],
                    ),
                    CommonBoxNew(
                      text: 'PROFILE',
                      route: '/profile',
                      fontSize: 25.0,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PendingTaskScreen(),
                      ));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      shadowColor: const Color.fromARGB(255, 7, 28, 255),
                      elevation: 10.0,
                      color: Colors.green,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: const Center(
                          child: Text(
                            'Pending Tasks',
                            // style: Theme.of(context).textTheme.headlineLarge,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     CommonBoxNew(
                //       text: 'LOGIN',
                //       route: '/login',
                //       fontSize: 25.0,
                //     ),
                //     CommonBoxNew(
                //       text: 'Register',
                //       route: '/register',
                //       fontSize: 25.0,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

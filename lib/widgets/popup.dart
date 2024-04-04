import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapp/click_screen.dart';
import 'package:tapp/task_screen.dart';
import 'package:tapp/utils/web.dart';
import 'package:tapp/variables/local_variables.dart';

class PopUp extends StatefulWidget {
  final int coins;
  final String taskname;
  const PopUp({super.key, required this.coins, required this.taskname});

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  late SharedPreferences _prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Center(
        child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width - 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 0, right: 10, bottom: 0),
              //   child: Container(
              //     height: 100,
              //     width: 100,
              //     decoration: const BoxDecoration(
              //       color: Colors.transparent,
              //       image: DecorationImage(
              //           image: AssetImage("assets/images/trophy.png"),
              //           fit: BoxFit.fill),
              //     ),
              //   ),
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 0),
                    child: Text(
                      "Congratulations!!!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 0),
                    child: Text(
                      "You Won ${widget.coins} Coins",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 0),
                    child: InkWell(
                      onTap: () async {
                        _prefs = await SharedPreferences.getInstance();

                        _prefs.setInt(widget.taskname,
                            DateTime.now().millisecondsSinceEpoch);
                        Navigator.pop(context);
                        // Navigator.popUntil(
                        //     context, ModalRoute.withName('/play'));
                        if (widget.taskname.contains('CLICK')) {
                          deviceId = _prefs.getString(deviceIdLabel)!;
                          updateCoins(deviceId, gameCoins.toString());
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ClickScreen(),
                            ),
                          );
                        }
                        if (widget.taskname.contains('TASK')) {
                          deviceId = _prefs.getString(deviceIdLabel)!;
                          updateCoins(deviceId, gameCoins.toString());
                          deviceId = _prefs.getString(deviceIdLabel)!;
                          updateCoins(deviceId, gameCoins.toString());
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TaskScreen(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 45,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 9),
                          child: Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

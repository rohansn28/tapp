import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapp/variables/local_variables.dart';

class PremiumCard extends StatefulWidget {
  final String route1, route2;
  const PremiumCard({
    super.key,
    required this.route1,
    required this.route2,
  });

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard> {
  late SharedPreferences _prefs;
  late DateTime _lastCompletion;
  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool _canPerformTask() {
    _lastCompletion = DateTime.fromMillisecondsSinceEpoch(
        _prefs.getInt('${phase}Coin-Completiontime') ?? 0);
    DateTime now = DateTime.now();

    Duration difference = now.difference(_lastCompletion);

    return difference.inHours >= 24;
  }

  void dialogbox() async {
    _prefs = await SharedPreferences.getInstance();

    _lastCompletion = DateTime.fromMillisecondsSinceEpoch(
        _prefs.getInt('${phase}Coin-Completiontime') ?? 0);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Task Locked'),
          content: Text(
              'You can perform this task again in ${_lastCompletion.add(const Duration(hours: 24))} hours.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              if (gameCoins < phase && _canPerformTask()) {
                Navigator.pushNamed(context, widget.route1);
              } else {
                dialogbox();
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the value as needed
              ),
              shadowColor: const Color.fromARGB(255, 7, 28, 255),
              elevation: 10.0,
              color: Colors.green,
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height * 0.17,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "MINI TASK",
                        // style: Theme.of(context).textTheme.headlineLarge,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 16.0,
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.35,
                    //   // height: MediaQuery.of(context).size.height * 0.06,
                    //   // color: Colors.white,
                    //   child: const Text(
                    //     '"MINIMUM 10000 COINS REQUIRED TO USE THIS"',
                    //     style: TextStyle(
                    //       fontSize: 12.0,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, widget.route2);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the value as needed
              ),
              shadowColor: const Color.fromARGB(255, 7, 28, 255),
              elevation: 10.0,
              color: Colors.green,
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height * 0.17,
                child: const Center(
                    child: Text(
                  'NEED HELP?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

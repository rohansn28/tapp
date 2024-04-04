import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapp/variables/local_variables.dart';

class CommonBoxNew extends StatefulWidget {
  final String text;

  final String route;
  final double fontSize;
  const CommonBoxNew({
    super.key,
    required this.text,
    required this.route,
    required this.fontSize,
  });

  @override
  State<CommonBoxNew> createState() => _CommonBoxNewState();
}

class _CommonBoxNewState extends State<CommonBoxNew> {
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

  void dialogbox() async {
    _prefs = await SharedPreferences.getInstance();

    _lastCompletion = DateTime.fromMillisecondsSinceEpoch(
        _prefs.getInt('${phase}Coin-Completiontime') ?? 0);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(textAlign: TextAlign.center, 'Task Locked'),
          content: Text(
              textAlign: TextAlign.center,
              'New Tasks available on \n${_lastCompletion.add(const Duration(hours: 24))}.'),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ),
          ],
        );
      },
    );
  }

  bool _canPerformTask() {
    _lastCompletion = DateTime.fromMillisecondsSinceEpoch(
        _prefs.getInt('${phase}Coin-Completiontime') ?? 0);

    DateTime now = DateTime.now();
    Duration difference = now.difference(_lastCompletion);

    return difference.inHours >= 24;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          if (gameCoins <= phase && _canPerformTask()) {
            Navigator.pushNamed(context, widget.route);
          } else {
            dialogbox();
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          shadowColor: const Color.fromARGB(255, 7, 28, 255),
          elevation: 10.0,
          color: Colors.green,
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.height * 0.17,
            child: Center(
              child: Text(
                widget.text,
                // style: Theme.of(context).textTheme.headlineLarge,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

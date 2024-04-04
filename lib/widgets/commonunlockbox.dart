import 'package:flutter/material.dart';

class CommonUnlockBox extends StatelessWidget {
  final String text;
  final double fontSize;
  const CommonUnlockBox({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(textAlign: TextAlign.center, 'Game Locked'),
                content: const Text(
                    textAlign: TextAlign.center,
                    'Minimum 200 value required to Unlock'),
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
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
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

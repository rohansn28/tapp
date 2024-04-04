import 'package:flutter/material.dart';
import 'package:tapp/controllers/local_store.dart';

class StartPg extends StatefulWidget {
  const StartPg({super.key});

  @override
  State<StartPg> createState() => _StartPgState();
}

class _StartPgState extends State<StartPg> {
  @override
  void initState() {
    super.initState();
    initPrefs(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff9ed395),
      child: Column(
        children: [
          const SizedBox(
            height: 180,
          ),
          Center(
            child: Container(
              height: 210,
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                    image: AssetImage("assets/images/logo1.png"),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(9.0),
            child: Text(
              "TaskApp",
              textScaleFactor: 4.5,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                //fontSize: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

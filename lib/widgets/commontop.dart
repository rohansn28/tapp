import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapp/utils/web.dart';

import 'package:tapp/variables/local_variables.dart';

class Commontop extends StatefulWidget {
  const Commontop({
    super.key,
  });

  @override
  State<Commontop> createState() => _CommontopState();
}

class _CommontopState extends State<Commontop> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  Future<void> getUserId() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('uId')!;
    });
  }

  String userid = '';

  @override
  Widget build(BuildContext context) {
    print(gameCoins);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 8.9 + 20,
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Color.fromARGB(255, 255, 255, 255)),
          child: Column(
            children: [
              const Text(
                'Coins',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              FutureBuilder<List<dynamic>>(
                future: userCoins(userid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // print(snapshot.data![0]['totcoins']);
                    return Text(
                      gameCoins
                          .toString(), //snapshot.data![0]['totcoins'].toString(),
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
        const VerticalDivider(
          width: 8.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 8.9 + 20,
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Color.fromARGB(255, 255, 255, 255)),
          child: Column(
            children: [
              const Text(
                'Value',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              FutureBuilder<List<dynamic>>(
                future: userCoins(userid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // print(snapshot.data![0]['totcoins']);
                    return Text(
                      (snapshot.data![0]['totcoins'] / 100).toString(),
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

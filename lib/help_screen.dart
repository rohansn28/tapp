import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapp/game_home.dart';
import 'package:tapp/utils/chrome_custom_tabs.dart';
import 'package:tapp/variables/local_variables.dart';
import 'package:tapp/variables/modal_variable.dart';
import 'package:tapp/widgets/commonadmarkbottom.dart';
import 'package:tapp/widgets/commonmincoinbar.dart';
import 'package:tapp/widgets/commontop.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  Future<void> _refreshData() async {
    // Fetch updated data from shared preferences

    int updatedCoins = await SharedPreferences.getInstance().then((prefs) {
      return prefs.getInt(gameCoinsLabel) ?? 0;
    });

    // Update UI
    setState(() {
      gameCoins = updatedCoins;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(Icons.arrow_back),
          onTap: () async {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const GameHome(),
              ),
            );
          },
        ),
        title: const Text('HELP'),
      ),
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
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.white,
                  child: Center(
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            launchCustomTabURL(
                                context, otherLinksModel.otherlinks![5].link);
                          },
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              color: Colors.green,
                              border: Border.all(color: Colors.black),
                            ),
                            child: const Center(
                              child: Text(
                                'CONTACT US',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const AdMarkBottom()
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.width * 0.3,
                  color: Colors.white,
                  child: Center(
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            launchCustomTabURL(
                                context, otherLinksModel.otherlinks![6].link);
                          },
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              color: Colors.green,
                              border: Border.all(color: Colors.black),
                            ),
                            child: const Center(
                              child: Text(
                                'PRIVACY POLICY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const AdMarkBottom(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  // height: MediaQuery.of(context).size.width * 0.3,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const Text(
                        'Rules!!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        otherLinksModel.otherlinks![9].link,
                        style: const TextStyle(
                            // color: Colors.white,
                            // fontWeight: FontWeight.w900,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

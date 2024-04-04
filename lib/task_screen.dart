import 'package:flutter/material.dart';
import 'package:tapp/game_home.dart';
import 'package:tapp/model/applink.dart';
import 'package:tapp/utils/web.dart';
import 'package:tapp/variables/local_variables.dart';
import 'package:tapp/variables/modal_variable.dart';
import 'package:tapp/widgets/commonmincoinbar.dart';
import 'package:tapp/widgets/commontask.dart';
import 'package:tapp/widgets/commontop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late SharedPreferences _prefs;
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
            if (gameCoins >= phase && phase != 0) {
              _prefs = await SharedPreferences.getInstance();
              _prefs.setInt('${phase}Coin-Completiontime',
                  DateTime.now().millisecondsSinceEpoch);
            }
          },
        ),
        title: const Text('TASK'),
      ),
      body: PopScope(
        onPopInvoked: (didPop) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const GameHome(),
              ),
            );
          });
        },
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
                Expanded(
                  child: FutureBuilder<List<Applink>>(
                    future: fetchTasklineData('tasklinelinks'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return commontask(
                              btnText: "TASK ${index + 1}",
                              stayTime: "50",
                              winCoin: "300",
                              url: snapshot.data![index].link,
                              index: index,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return const Center(
                        child: Text(
                          'Loading...',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
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

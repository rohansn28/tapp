import 'package:flutter/material.dart';
import 'package:tapp/game_home.dart';
import 'package:tapp/model/applink.dart';
import 'package:tapp/model/task.dart';
import 'package:tapp/utils/web.dart';

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
  String uid = '';

  void initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getKeys());
    setState(() {
      uid = prefs.getString('uId')!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    // newTaskData(uid);
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
                // CommonMinCoinBar(
                //   text1: otherLinksModel.otherlinks![7].link,
                //   text2: otherLinksModel.otherlinks![8].link,
                // ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Task Available: 7',
                        style: TextStyle(color: Colors.white)),
                    Text('Coins Available to Earn: 1500',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                const Text('Pending Coins: 800',
                    style: TextStyle(color: Colors.white)),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: FutureBuilder<List<Task>>(
                    future: taskData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return commontask(
                              taskname: snapshot.data![index].taskname,
                              taskdesc: snapshot.data![index].taskdesc,
                              taskinst: snapshot.data![index].taskinst,
                              uid: uid,
                              index: snapshot.data![index].id,
                              taskcoin: snapshot.data![index].tcoin,
                              taskfrequency: snapshot.data![index].tfrequency,
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

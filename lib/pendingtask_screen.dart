import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapp/model/pendingtask.dart';

import 'package:tapp/utils/web.dart';

class PendingTaskScreen extends StatefulWidget {
  const PendingTaskScreen({super.key});

  @override
  State<PendingTaskScreen> createState() => _PendingTaskScreenState();
}

class _PendingTaskScreenState extends State<PendingTaskScreen> {
  String uid = '';

  void initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('PENDING TASKS'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<PendingTask>>(
                  future: pendingTasks(uid),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].userId.toString(),
                                    // style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    snapshot.data![index].tname,
                                    // style: const TextStyle(color: Colors.white),
                                  ),
                                  ReadMoreText(
                                    snapshot.data![index].tdesc,
                                    trimLines: 5,
                                  ),
                                  Text(
                                    snapshot.data![index].tinst,
                                    // style: const TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                      color: snapshot.data![index].taskstatus ==
                                              'approved'
                                          ? Colors.green
                                          : snapshot.data![index].taskstatus ==
                                                  'rejected'
                                              ? Colors.red
                                              : Colors.grey,
                                    ),
                                    child: Text(
                                      snapshot.data![index].taskstatus,
                                      style: TextStyle(color: Colors.white),
                                      // style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
    );
  }
}

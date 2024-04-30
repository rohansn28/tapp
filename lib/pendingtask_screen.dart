import 'package:flutter/material.dart';
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
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Text(
                                snapshot.data![index].userId,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                snapshot.data![index].tname,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                snapshot.data![index].tdesc,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                snapshot.data![index].tinst,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
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

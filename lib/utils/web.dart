// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapp/controllers/local_store.dart';
import 'package:tapp/model/applink.dart';
import 'package:tapp/model/pendingtask.dart';
import 'package:tapp/model/task.dart';
import 'package:tapp/variables/local_variables.dart';
import 'package:tapp/variables/modal_variable.dart';

Future<List<Applink>> fetchPlayData(String endpoint) async {
  var url = Uri.parse("$baseUrl$basePostFix$endpoint");

  var response = await http.get(url);
  List<Applink> applinks = applinkFromJson(response.body);

  return applinks;
}

Future<List<Applink>> fetchTasklineData(String endpoint) async {
  var url = Uri.parse("$baseUrl$basePostFix$endpoint");

  var response = await http.get(url);
  List<Applink> applinks = applinkFromJson(response.body);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  for (var i = 0; i < applinks.length; i++) {
    prefs.setBool('task ${applinks[i].id} completed', false);
  }

  // print(applinks.first.id.runtimeType);

  return applinks;
}

Future<List<Task>> mainTasks() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = Uri.parse("http://10.0.2.2:8000/api/tasks");
  var len = 0;

  var response = await http.get(url);
  List<Task> applinks = taskFromJson(response.body);

  for (var i = 0; i < applinks.length; i++) {
    len += 1;
    if (prefs.getBool('task ${applinks[i].id} completed') == null) {
      prefs.setBool('task ${applinks[i].id} completed', false);
    }
  }
  prefs.setInt('tasklen', len);
  tasklen = prefs.getInt('tasklen')!;

  return applinks;
}

Future<List<dynamic>> userCoins(String id) async {
  var url = Uri.parse("http://10.0.2.2:8000/api/user/$id");
  var response = await http.get(url);
  var data = jsonDecode(response.body);
  // print(data);

  return data;
}

Future<void> testFunCoin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString('uId');

  var url = Uri.parse('http://10.0.2.2:8000/api/pendingtask/$uid');

  var response = await http.get(url);

  List<Task> taskList = await taskData();
  // print(taskList.first.tcoin);

  List<PendingTask> pendingtasks = pendingTaskFromJson(response.body);
  // print(pendingtasks);

  for (var i = 0; i < pendingtasks.length; i++) {
    if (pendingtasks[i].taskstatus == 'approved' &&
        prefs.getBool('Task-${taskList[i].id}-Coins-Added') == false) {
      var coins = taskList[i].tcoin;

      increaseGameCoin(coins);

      prefs.setBool('Task-${taskList[i].id}-Coins-Added', true);
    }
  }
}

Future<void> gameHomeMainTasks() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString('uId');
  var url = Uri.parse("http://10.0.2.2:8000/api/tasks");
  var len = 0;

  var response = await http.get(url);
  List<Task> taskList = taskFromJson(response.body);
  List<PendingTask> pendingTaskList = await pendingTasks(uid!);
  int freq = 0;

  for (var i = 0; i < taskList.length; i++) {
    len += 1;
  }

  for (var i = 0; i < 1; i++) {
    for (var j = 0; j < pendingTaskList.length; j++) {
      if (pendingTaskList[j].taskcreatetime.isBefore(DateTime.now())) {
        for (var z = 0; z < taskList.length; z++) {
          if (taskList[z].id == int.parse(pendingTaskList[j].taskid)) {
            freq = taskList[z].tfrequency;
          }
        }
        if (DateTime.now()
                .difference(pendingTaskList[i].taskcreatetime)
                .inMinutes >
            freq) {
          prefs.setBool('Task-${taskList[i].id}-Coins-Added', false);
          prefs.setBool('task ${taskList[i].id} completed', false);
          // print(taskDatabyId[i].taskid);
          // prefs.setBool('task ${taskDatabyId[i].taskid} completed', false);
        }
      }
    }

    // if (prefs.containsKey('task ${taskList[i].id} completed')) {
    //   //check count for available tasks in red circle
    // } else {
    //   prefs.setBool('task ${taskList[i].id} completed', false);
    // }
  }
  prefs.setInt('tasklen', len);
  tasklen = prefs.getInt('tasklen')!;
}

Future<int?> newNotifications() async {
  var url = Uri.parse("http://10.0.2.2:8000/api/tasks");
  var response = await http.get(url);
  List<Task> taskdata = taskFromJson(response.body);

  var tasklengthNew = taskdata.length;
  print({tasklen, tasklengthNew});
  var finallength = (tasklen - tasklengthNew).abs();

  return finallength;
}

Future<List<Task>> taskData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<Task> finList = [];
  var url = Uri.parse("http://10.0.2.2:8000/api/tasks");

  var response = await http.get(url);

  List<Task> applinks = taskFromJson(response.body);
  // print(taskDatabyId.first.createdAt);

  for (var i = 0; i < applinks.length; i++) {
    if (prefs.getBool('task ${applinks[i].id} completed') == false) {
      finList.add(applinks[i]);
    }
  }

  return finList;
}

// Future<List<Task>> newTaskData(String uid) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   List<Task> task = await taskData();
//   int freq = 0;

//   List<Task> finList = [];
//   var urlForTaskbyId = Uri.parse("http://10.0.2.2:8000/api/pendingtask/$uid");

//   var responseForTaskbyId = await http.get(urlForTaskbyId);

//   List<PendingTask> taskDatabyId =
//       pendingTaskFromJson(responseForTaskbyId.body);

//   for (var i = 0; i < task.length; i++) {}

//   for (var j = 0; j < taskDatabyId.length; j++) {
//     if (taskDatabyId[j].taskcreatetime.isBefore(DateTime.now())) {
//       for (var z = 0; z < task.length; z++) {
//         if (task[z].id == int.parse(taskDatabyId[i].taskid)) {
//           freq = task[z].tfrequency;
//         }
//       }
//       if (DateTime.now().difference(taskDatabyId[i].taskcreatetime).inMinutes >
//           freq) {
//         print(taskDatabyId[i].taskid);
//         prefs.setBool('task ${taskDatabyId[i].taskid} completed', false);
//       }
//     }
//   }
//   // for (var i = 0; i < taskDatabyId.length; i++) {
//   //   // if (taskDatabyId[i].taskcreatetime.isBefore(DateTime.now())) {
//   //   //   if (DateTime.now().difference(taskDatabyId[i].taskcreatetime).inMinutes >
//   //   //       freq) {
//   //   //     print(taskDatabyId[i].taskid);
//   //   //     prefs.setBool('task ${taskDatabyId[i].taskid} completed', false);
//   //   //   }
//   //   // }
//   // }

//   return task;
// }

Future<String> fetchButtonLinks(String endpoint) async {
  var url = Uri.parse("$baseUrl$basePostFix$endpoint");

  var response = await http.get(url);

  if (response.statusCode == 200) {
    otherLinksModel = OtherLinksModel.fromJson(jsonDecode(
        response.body.toString())); //otherLinksModel.otherlinks![0].link
    if (otherLinksModel.otherlinks![0].link.trim() == '1') {
      objLive = true;
    }
    return response.body;
  } else {
    return "0";
    //check connection
  }
}

Future<void> sendDeviceIdToBackend(String deviceID, String coins) async {
  const url = 'https://loungecard.website/public/api/register';

  // final headers = {
  //   'Content-Type': 'application/json',
  //   // Add any additional headers if required
  // };
  // final body = json.encode({
  //   'name': deviceID,
  //   'coins': '20',
  //   // You can include additional data if needed
  // });

  try {
    final response = await http.post(
      Uri.parse(url),
      // headers: headers,
      body: {
        'name': deviceID,
        'coins': coins,
      },
    );

    if (response.statusCode == 200) {
      // Registration successful
      print('Device ID sent successfully!');
    } else {
      // Registration failed
      print('Failed to send device ID. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending device ID: $e');
  }
}

Future<void> updateCoins(String deviceID, String coins) async {
  const url = 'https://loungecard.website/public/api/update-coins';

  try {
    final response = await http.post(
      Uri.parse(url),
      // headers: headers,
      body: {
        'name': deviceID,
        'coins': coins,
      },
    );

    if (response.statusCode == 200) {
      print('Device ID sent successfully!');
    } else {
      print('Failed to send device ID. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending device ID: $e');
  }
}

Future<void> login(BuildContext context, String email, String password) async {
  // const url = 'https://loungecard.website/tapp/public/api/login';
  const url = 'http://10.0.2.2:8000/api/login';
  final dio = Dio();

  final response = await dio.post(url, data: {
    'email': email,
    'password': password,
  });

  if (response.statusCode == 200) {
    String token = response.data['token'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenLabel, token);
    await prefs.setString('uId', response.data['user']['id'].toString());
    await prefs.setString('uName', response.data['user']['name']);
    await prefs.setString('uEmail', response.data['user']['email']);
    await prefs.setString('uMobile', response.data['user']['mobile']);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.data['message'])),
    );
    Navigator.pushReplacementNamed(context, '/gamehome');
  }
}

Future<void> register(BuildContext context, String email, String password,
    String mobile, String name) async {
  // const url = 'https://loungecard.website/tapp/public/api/register';
  const url = 'http://10.0.2.2:8000/api/register';
  final dio = Dio();

  final response = await dio.post(url, data: {
    'name': name,
    'email': email,
    'mobile': mobile,
    'password': password,
  });

  if (response.statusCode == 200) {
    // print(response.data);

    // var responseData = json.decode(response.data);
    String token = response.data['token'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(tokenLabel, token);
    Navigator.pushReplacementNamed(context, '/login');
  }
}

Future<List<PendingTask>> pendingTasks(String uid) async {
  var url = Uri.parse('http://10.0.2.2:8000/api/pendingtask/$uid');

  var response = await http.get(url);
  List<PendingTask> pendingtasks = pendingTaskFromJson(response.body);

  return pendingtasks;
}

Future<void> logout(BuildContext context) async {
  // Clear authentication token from local storage
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  // Call your authentication service to perform any additional cleanup
  // AuthService.logout();

  // Navigate user back to login screen
  Navigator.pushReplacementNamed(context, '/');
}

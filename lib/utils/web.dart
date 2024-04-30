// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
  var url = Uri.parse("http://10.0.2.2:8000/api/tasks");

  var response = await http.get(url);
  List<Task> applinks = taskFromJson(response.body);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  for (var i = 0; i < applinks.length; i++) {
    prefs.setBool('task ${applinks[i].id} completed', false);
  }

  return applinks;
}

Future<List<Applink>> taskData(String endpoint) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<Applink> finList = [];
  var url = Uri.parse("http://10.0.2.2:8000/api/tasks");
  var response = await http.get(url);
  List<Applink> applinks = applinkFromJson(response.body);
  for (var i = 0; i < applinks.length; i++) {
    if (prefs.getBool('task ${applinks[i].id} completed')! == false) {
      finList.add(applinks[i]);
    }
  }

  return finList;
}

Future<List<Applink>> fetchBonusData(String endpoint) async {
  var url = Uri.parse("$baseUrl$basePostFix$endpoint");

  var response = await http.get(url);
  List<Applink> applinks = applinkFromJson(response.body);

  return applinks;
}

Future<List<Applink>> fetchGameData(String endpoint) async {
  var url = Uri.parse("$baseUrl$basePostFix$endpoint");

  var response = await http.get(url);
  List<Applink> applinks = applinkFromJson(response.body);

  return applinks;
}

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

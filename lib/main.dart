import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tapp/click_screen.dart';
import 'package:tapp/game_home.dart';
import 'package:tapp/login_screen.dart';
import 'package:tapp/profile_screen.dart';
import 'package:tapp/register_screen.dart';
import 'package:tapp/resumetracking_screen.dart';

import 'package:tapp/task_screen.dart';

import 'package:tapp/utils/web.dart';
import 'package:tapp/variables/local_variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initOneSignal();

  // String check = await fetchButtonLinks('buttonlinks');
  // if (check != "0") {}
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // fetchData();
    return MaterialApp(
      title: 'TApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 98, 42, 71),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.green,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: const AuthenticationWrapper(),
      routes: {
        "/gamehome": (context) => const GameHome(),
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/click": (context) => const ClickScreen(),
        "/task": (context) => const TaskScreen(),
        "/profile": (context) => const ProfileScreen(),
        // "/startpg": (context) => const StartPg(),

        "/tracking": (context) => const ResumeTrackingScreen(),
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkIfLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.data == true) {
            return const GameHome();
          } else {
            return LoginScreen();
          }
        }
      },
    );
  }

  Future<bool> checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenLabel);
    return token != null;
  }
}

// void initOneSignal() {
//   //Remove this method to stop OneSignal Debugging
//   OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

//   OneSignal.initialize("0aee07dd-fa8b-4d72-b419-b951aa223c76");

// // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//   OneSignal.Notifications.requestPermission(true);
// }



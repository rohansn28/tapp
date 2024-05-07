import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapp/utils/web.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences preferences;
  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void getUserData() async {
    setState(() {
      isloading = true;
    });
    preferences = await SharedPreferences.getInstance();

    // userCoins(int.parse(preferences.getString('uId')!));
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE PAGE'),
      ),
      body: SafeArea(
        child: isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Name : ${preferences.getString('uId')!}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Name : ${preferences.getString('uName')!}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Mobile No. : ${preferences.getString('uMobile')!}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Email : ${preferences.getString('uEmail')!}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

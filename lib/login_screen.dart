import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapp/register_screen.dart';
import 'package:tapp/utils/validators.dart';
import 'package:tapp/utils/web.dart';
import 'package:tapp/controllers/local_store.dart';
import 'package:tapp/variables/local_variables.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    initPrefs(context);
  }

  final formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  errorStyle: TextStyle(color: Colors.white),
                ),
                validator: ValidatorCheck.validateEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 12),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  errorStyle: TextStyle(color: Colors.white),
                ),
                validator: ValidatorCheck.isPasswordValid,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    login(
                      context,
                      emailController.text,
                      passwordController.text,
                    );
                  }
                  // SharedPreferences prefs =
                  //     await SharedPreferences.getInstance();
                  // String? token = prefs.getString(tokenLabel);
                  // print(token);
                  // if (token != null) {
                  //   Navigator.pushNamed(context, '/gamehome');
                  // }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Don't have an account",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

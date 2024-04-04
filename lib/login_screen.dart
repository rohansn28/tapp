import 'package:flutter/material.dart';
import 'package:tapp/utils/validators.dart';
import 'package:tapp/utils/web.dart';
import 'package:tapp/controllers/local_store.dart';

final formkey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    initPrefs(context);
  }

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
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Perform login logic here
                  // String email = emailController.text;
                  // String password = passwordController.text;
                  // You can add validation and backend logic here
                  formkey.currentState!.validate();
                  login(emailController.text, passwordController.text);
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

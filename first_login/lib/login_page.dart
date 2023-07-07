import 'dart:convert';

import 'package:first_login/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _seePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      label: Text('email'), hintText: 'name@mail.com'),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !_seePassword,
                    decoration: InputDecoration(
                      label: const Text('password'),
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _seePassword = !_seePassword;
                          });
                        },
                        icon: Icon(_seePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                      ),
                    ),
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Enter your password';
                      } else if (password.length <= 8) {
                        return 'Enter a stronger password';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  child: const Text('Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('');
    var response = await http.post(
      url,
      body: {
        'username': _emailController.text,
        'password': _passwordController.text,
      },
    );
    if (response.statusCode == 200) {
      String token = jsonDecode(response.body)['token'];
      await _sharedPreferences.setString('token', 'Token $token');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Email our password incorrect'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
}

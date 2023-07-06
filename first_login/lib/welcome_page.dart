import 'package:first_login/home_page.dart';
import 'package:first_login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    authUser().then((hasUser) {
      if (hasUser) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome",
        ),
      ),
    );
  }

  Future<bool> authUser() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = _sharedPreferences.getString('token');
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
}

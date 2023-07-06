import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                  decoration: const InputDecoration(
                      label: Text('email'), hintText: 'name@mail.com'),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Digite seu e-mail';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        label: Text('password'),
                        hintText: 'Enter your password'),
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Digite sua senha';
                      } else if (password.length <= 8) {
                        return 'Digite uma senha mais forte';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
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
}

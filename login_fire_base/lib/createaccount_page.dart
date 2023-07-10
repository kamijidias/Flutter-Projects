import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: ListView(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              label: Text('Full Name')
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              label: Text('E-mail')
            ),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              label: Text('Password')
            ),
          ),
          ElevatedButton(
            onPressed: () {
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }
}

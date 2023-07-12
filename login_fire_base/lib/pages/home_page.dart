import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_fire_base/pages/auth_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _avatar = const CircleAvatar(child: Icon(Icons.person),);
  String email = '';

  @override
  initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text(email),
              accountName: null,
              currentAccountPicture: _avatar,
            ),
            ListTile(
                dense: true,
                title: const Text('Logout'),
                trailing: const Icon(Icons.exit_to_app),
                onTap: () {
                  logout();
                })
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            email,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  getUser() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      setState(() {
        email = user.email!;
      });
    }
  }

  logout() async {
    await _firebaseAuth.signOut().then(
          (user) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthPage(),
            ),
          ),
        );
  }
}

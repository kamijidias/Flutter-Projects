// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls, use_build_context_synchronously, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:full_login/pages/edit_user.dart';
import 'package:full_login/pages/login.dart';
import 'package:full_login/utils/get_user_data.dart';
import 'package:full_login/utils/user_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showRegisterPage = false;
  final user = FirebaseAuth.instance.currentUser!;

  final _searchController = TextEditingController();

  // document IDs
  List<String> docIDs = [];

  List<String> filteredDocIDs = [];

  @override
  void initState() {
    super.initState();
    refreshData(docIDs).then((_) {
      setState(() {});
    });
  }

  Future<void> deleteUser(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(documentId)
          .delete();

      await refreshData(docIDs);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(255, 32, 155, 95),
          content: Text('You have successfully deleted'),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (route) => false,
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Error deleting user'),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void showDeleteConfirmationDialog(String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                Navigator.of(context).pop();

                deleteUser(docId);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSearchDialog(BuildContext context) async {
    String? searchTerm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Search by First Name'),
          content: TextField(
            controller: _searchController,
            decoration: InputDecoration(hintText: 'Search'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, _searchController.text);
              },
              child: Text('Filter'),
            ),
          ],
        );
      },
    );

    if (searchTerm != null) {
      filterData(searchTerm);
    }
  }

  Future<void> filterData(String searchTerm) async {
    if (searchTerm.isEmpty) {
      filteredDocIDs = List.from(docIDs);
    } else {
      filteredDocIDs.clear();
      for (String docID in docIDs) {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(docID)
            .get();

        if (snapshot.exists) {
          Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

          if (data != null) {
            String firstName = data['first name'];
            String lastName = data['last name'];
            String email = data['email'];

            if (firstName.toLowerCase().contains(searchTerm.toLowerCase()) ||
                lastName.toLowerCase().contains(searchTerm.toLowerCase()) ||
                email.toLowerCase().contains(searchTerm.toLowerCase())) {
              filteredDocIDs.add(docID);
            }
          }
        }
      }
    }

    if (filteredDocIDs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orange,
          content: Text('User not found'),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    setState(() {});
  }

  void _clearFilter() {
    _searchController.clear();
    setState(() {
      filteredDocIDs = List.from(docIDs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          user.email!,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showSearchDialog(context);
            },
            icon: Icon(Icons.search),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Logout'),
                    content: Text('Are you sure you want to log out?'),
                    actions: [
                      ButtonBar(
                        children: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Logout'),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'List of Users',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _clearFilter,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      minimumSize: Size(100, 30),
                    ),
                    child: Text('Clear filter'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<void>(
                future: Future.value(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<String> displayList = _searchController.text.isEmpty
                        ? docIDs
                        : filteredDocIDs;
                    return ListView.builder(
                      itemCount: displayList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: GetUserData(
                              key: Key(docIDs[index]),
                              documentId: displayList[index],
                            ),
                            tileColor: Colors.grey[200],
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditUser(userId: docIDs[index]),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    DocumentSnapshot document =
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(docIDs[index])
                                            .get();

                                    String userId = document.get('userId');

                                    if (userId == user.uid) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                'Cannot delete your own account'),
                                            content: Text(
                                                'You are not allowed to delete your own account.'),
                                            actions: [
                                              TextButton(
                                                child: Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      showDeleteConfirmationDialog(
                                          docIDs[index]);
                                    }
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: empty_constructor_bodies, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserData extends StatelessWidget {
  final String documentId;

  const GetUserData({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get the collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic>? data =
                snapshot.data!.data() as Map<String, dynamic>?;

            if (data != null) {
              return Text('${data['first name']} ${data['last name']}');
            }
          }
          return Text('User not found');
        }
        return Text('loading..');
      },
    );
  }
}

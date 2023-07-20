import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HighScores extends StatelessWidget {
  final String documentId;
  const HighScores({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    //get the collection of highscores
    CollectionReference highscores =
        FirebaseFirestore.instance.collection('highscores');

    return FutureBuilder<DocumentSnapshot>(
      future: highscores.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Row(
            children: [
              Text(
                data['score'].toString(),
                style: const TextStyle(color: Colors.redAccent),
              ),
              const SizedBox(
                width: 10,
                height: 20,
              ),
              Text(
                data['name'],
                style: const TextStyle(color: Colors.blue),
              ),
            ],
          );
        } else {
          return const Text('Loading...');
        }
      },
    );
  }
}

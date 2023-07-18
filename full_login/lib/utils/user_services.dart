// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> refreshData(List<String> docIDs) async {
  docIDs.clear();

  await FirebaseFirestore.instance
      .collection('users')
      .orderBy('age', descending: true)
      .get()
      .then((snapshot) {
    snapshot.docs.forEach((document) {
      docIDs.add(document.reference.id);
    });
  });
}



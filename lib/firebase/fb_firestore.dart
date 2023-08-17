import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_app/models/messages.dart';

import '../utils/constants.dart';

class FBFirestore {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> create({required Message message}) async {
    return await _firestore.collection(KMessageCollection).add(message.toMap()).then((value) {
      print(' message with id :${value.id} added successfully');
      return true;
    }).catchError((error) => false);
  }


  Stream<QuerySnapshot> read() async*{
    yield* _firestore.collection(KMessageCollection).orderBy(KTime,descending: true).snapshots();
  }


}

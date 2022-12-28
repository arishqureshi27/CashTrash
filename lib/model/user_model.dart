import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserMode {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String phone;

  UserMode({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  factory UserMode.fromDocument(DocumentSnapshot doc) {
    return UserMode(
      uid: doc['uid'],
      name: doc['name'],
      email: doc['email'],
      password: doc['password'],
      phone: doc['phone_number'],
    );
  }
}

late UserMode userModel;
Future getCurrentUserData() async {
  DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
}

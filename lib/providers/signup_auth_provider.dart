import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpAuthProvider with ChangeNotifier {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static bool loading = false;

  RegExp regExp = RegExp(SignUpAuthProvider.pattern.toString());
  UserCredential? usercredential;

  void signupValidation({
    required TextEditingController name,
    required TextEditingController email,
    required TextEditingController password,
    required TextEditingController confirmPass,
    required TextEditingController phone,
    required BuildContext context,
  }) async {
    if (name.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name is Empty'),
        ),
      );
      return;
    } else if (email.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('email is Empty'),
        ),
      );
      return;
    } else if (!regExp.hasMatch(email.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Email Address'),
        ),
      );
      return;
    } else if (password.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password is Empty'),
        ),
      );
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be of 8 characters'),
        ),
      );
    } else if (confirmPass.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Confirm Password is Empty'),
        ),
      );
      return;
    } else if (confirmPass.text != password.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords does not match'),
        ),
      );
      return;
    } else if (phone.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone Number is Empty '),
        ),
      );
      return;
    } else if (phone.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Phone Number'),
        ),
      );
      return;
    } else {
      try {
        loading = true;
        notifyListeners();
        usercredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
        loading = true;
        notifyListeners();
        FirebaseFirestore.instance
            .collection("users")
            .doc(usercredential!.user!.uid)
            .set(
          {
            'uid': usercredential!.user!.uid,
            'name': name.text,
            'email': email.text,
            'password': password.text,
            'phone_number': phone.text,
          },
        ).then((value) {
          loading = false;
          notifyListeners();
          Navigator.pushReplacementNamed(context, '/login-page');
        });
      } on FirebaseAuthException catch (e) {
        loading = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.code,
            ),
          ),
        );
      }
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginAuthProvider with ChangeNotifier {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  bool loading = false;
  UserCredential? usercredential;
  RegExp regExp = RegExp(LoginAuthProvider.pattern.toString());

  void loginValidation({
    required TextEditingController email,
    required TextEditingController password,
    required BuildContext context,
  }) async {
    if (email.text.trim().isEmpty) {
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
    } else {
      try {
        loading = true;
        notifyListeners();

        usercredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        )
            .then((value) {
          loading = false;
          notifyListeners();

          Navigator.pushNamed(
            context,
            '/dashboard',
          );
        });
      } on FirebaseAuthException catch (e) {
        loading = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.code),
          ),
        );
      }
    }
  }
}

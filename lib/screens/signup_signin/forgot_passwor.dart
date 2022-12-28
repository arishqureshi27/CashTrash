import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/customized_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //final TextEditingController _emailController = TextEditingController();
  late String _email;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Forgot Password?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "Dont worry it occurs to us all. We will send you a link to reset your password.",
                  style: TextStyle(
                    color: Color(0xff8391A1),
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                  )),
            ),
            // CustomizedTextfield(
            //   myController: _emailController,
            //   hintText: "Enter your Email",
            //   isPassword: false,
            // ),
            // CustomizedButton(
            //   buttonText: "Send Code",
            //   buttonColor: Colors.black,
            //   textColor: Colors.white,
            //   onPressed: () {
            //     auth.sendPasswordResetEmail(email: _emailController);
            //   },
            // ),

            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: ('Enter your email'),
                hintStyle: TextStyle(
                  fontSize: 20,
                ),
                hintTextDirection: TextDirection.ltr,
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),

            CustomizedButton(
              buttonColor: Colors.black,
              buttonText: 'Send Code',
              textColor: Colors.white,
              onPressed: () {
                auth.sendPasswordResetEmail(email: _email);
                Navigator.of(context).pop();
              },
            ),

            const Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Remember Password?",
                    style: TextStyle(
                      color: Color(0xff1E232C),
                      fontSize: 15,
                    )),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text("  Login",
                      style: TextStyle(
                        color: Color(0xff35C2C1),
                        fontSize: 15,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    ));
  }
}

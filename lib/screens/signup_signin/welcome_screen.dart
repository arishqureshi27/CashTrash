import 'package:flutter/material.dart';
import '../../widgets/customized_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/bg1.jpg"))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomizedButton(
                buttonText: "Login",
                buttonColor: Colors.green.shade900,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/login-page');
                },
              ),
              CustomizedButton(
                buttonText: "Register",
                buttonColor: Colors.white,
                textColor: Colors.green.shade900,
                onPressed: () {
                  Navigator.pushNamed(context, '/register-page');
                },
              ),

              //  const SizedBox(height: 20),
              // const Padding(
              //    padding:  EdgeInsets.all(10.0),
              //    child: Text(
              //      "Continue as a Guest",
              //      style: TextStyle(color: Color(0xff35C2C1), fontSize: 25),
              //    ),
              //  )
            ],
          ),
        ),
      ),
    );
  }
}

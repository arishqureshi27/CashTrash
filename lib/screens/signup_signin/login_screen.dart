import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../providers/login_auth_provider.dart';

import '../../widgets/customized_textfield.dart';
import '../../widgets/customized_button.dart';
import './forgot_passwor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    LoginAuthProvider loginAuthProvider =
        Provider.of<LoginAuthProvider>(context);

    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green.shade900, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_sharp),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Welcome Back! Glad \nto see you again",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              CustomizedTextfield(
                myController: _emailController,
                hintText: "Enter your Email",
                isPassword: false,
              ),
              CustomizedTextfield(
                myController: _passwordController,
                hintText: "Enter your Password",
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword()));
                    },
                    child: const Text("Forgot Password?",
                        style: TextStyle(
                          color: Color(0xff6A707C),
                          fontSize: 15,
                        )),
                  ),
                ),
              ),

              // Login Button
              loginAuthProvider.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomizedButton(
                      buttonText: "Login",
                      buttonColor: Colors.green[800],
                      textColor: Colors.white,
                      onPressed: () {
                        loginAuthProvider.loginValidation(
                          email: _emailController,
                          password: _passwordController,
                          context: context,
                        );
                      },
                    ),

              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ",
                      style: TextStyle(
                        color: Color(0xff1E232C),
                        fontSize: 15,
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/register-page');
                    },
                    child: const Text("Register Now",
                        style: TextStyle(
                          color: Color(0xff35C2C1),
                          fontSize: 15,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

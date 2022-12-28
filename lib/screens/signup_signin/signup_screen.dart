import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/signup_auth_provider.dart';

import '../../widgets/customized_button.dart';
import '../../widgets/customized_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SignUpAuthProvider signupAuthProvider =
        Provider.of<SignUpAuthProvider>(context);

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
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Hello!  Register to get \nStarted",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                CustomizedTextfield(
                  myController: _usernameController,
                  hintText: "Name",
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: _emailController,
                  hintText: "Email",
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: _passwordController,
                  hintText: "Password",
                  isPassword: true,
                ),
                CustomizedTextfield(
                  myController: _confirmPasswordController,
                  hintText: "Confirm Password",
                  isPassword: true,
                ),
                CustomizedTextfield(
                  myController: _phonenumberController,
                  hintText: "Mobile Number",
                  isPassword: false,
                ),
                SignUpAuthProvider.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomizedButton(
                        buttonText: "Register",
                        buttonColor: Colors.green.shade900,
                        textColor: Colors.white,
                        onPressed: () {
                          signupAuthProvider.signupValidation(
                            name: _usernameController,
                            email: _emailController,
                            password: _passwordController,
                            confirmPass: _confirmPasswordController,
                            phone: _phonenumberController,
                            context: context,
                          );
                        },
                      ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",
                        style: TextStyle(
                          color: Color(0xff1E232C),
                          fontSize: 15,
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/login-page');
                      },
                      child: const Text("  Login Now",
                          style: TextStyle(
                            color: Color(0xff35C2C1),
                            fontSize: 15,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

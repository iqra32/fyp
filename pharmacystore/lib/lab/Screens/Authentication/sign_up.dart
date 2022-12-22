import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacystore/firebase_functions/getUser.dart';
import 'package:pharmacystore/lab/Screens/splash_screen.dart';
import 'package:pharmacystore/utils/data.dart';

import '../../Components/auth_button.dart';
import '../../Components/custom_text_field.dart';
import '../../Services/auth_services.dart';
import '../../Services/database_services.dart';

class SignUp extends StatefulWidget {
  final dynamic function;
  final String cast;
  const SignUp({Key? key, required this.function, required this.cast})
      : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool check = true;
  bool scroll = false;
  String? email;
  String? password;
  String? userName;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return scroll
        ? Scaffold(
            body: Center(
              child: Container(
                height: 100,
                child: Lottie.asset('assets/heart.json'),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white.withOpacity(0.9),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                validation: (value) => value!.isEmpty
                                    ? 'Please enter your username'
                                    : null,
                                hint: 'Enter Username',
                                prefixIcon: Icons.person,
                                onChanged: (val) {
                                  userName = val;
                                },
                              ),
                              CustomTextField(
                                validation: (value) => value!.isEmpty
                                    ? 'Please enter your email'
                                    : null,
                                keyboardtype: TextInputType.emailAddress,
                                hint: 'Enter Email',
                                prefixIcon: Icons.email,
                                onChanged: (val) {
                                  email = val;
                                },
                              ),
                              CustomTextField(
                                validation: (value) => value!.length < 6
                                    ? 'Please enter your password min of 6 char'
                                    : null,
                                hint: 'Enter Password',
                                prefixIcon: Icons.lock_sharp,
                                suffixIcon: check
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                check: check,
                                function: () {
                                  setState(() {
                                    check = !check;
                                  });
                                },
                                onChanged: (val) {
                                  password = val;
                                },
                              ),
                            ],
                          )),
                      const SizedBox(height: 40),
                      Center(
                        child: AuthButton(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                setState(() {
                                  scroll = true;
                                });
                                final result = await AuthServices()
                                    .createUserWithEmailAndPassword(
                                        email!, password!);
                                if (result != null) {
                                  DatabaseServices().addUserToDatabase(
                                    userName!,
                                    email!,
                                    password!,
                                    '',
                                    AuthServices().getUid(),
                                    widget.cast,
                                  );
                                  AppUser.data = await getUser();
                                  navigateToRole(widget.cast, context);
                                  Fluttertoast.showToast(
                                      msg: "Your account has been created",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  setState(() {
                                    scroll = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Email is badly formatted",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } catch (e) {
                                log(e.toString());
                                setState(() {
                                  scroll = false;
                                });
                              }
                            }
                          },
                          title: 'Sign Up',
                        ),
                      ),
                      Center(
                        child: Container(
                          child: Lottie.asset('assets/text.json'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have account? ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  InkWell(
                    onTap: this.widget.function,
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

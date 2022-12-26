// // ignore_for_file: library_private_types_in_public_api
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pharmacystore/utils/enums.dart';
// import 'package:pharmacystore/view/auth/login_screen.dart';
//
// class Register extends StatefulWidget {
//   Register({super.key});
//
//   @override
//   _RegisterState createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Register> {
//   _RegisterState();
//
//   bool showProgress = false;
//   bool visible = false;
//   final _formkey = GlobalKey<FormState>();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController confirmpassController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//
//   // Initial Selected Value
//   String selectedRole = 'Pharmacist';
//
//   // List of items in our dropdown menu
//   var items = [
//     'Pharmacist',
//     'Patient',
//   ];
//   bool _isObscure = true;
//   bool _isObscure2 = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[900],
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Container(
//               color: Colors.blue[900],
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               child: SingleChildScrollView(
//                 child: Container(
//                   margin: const EdgeInsets.all(12),
//                   child: Form(
//                     key: _formkey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const SizedBox(
//                           height: 80,
//                         ),
//                         const Text(
//                           "Register Now",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontSize: 40,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         TextFormField(
//                           controller: nameController,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: selectedRole == "Pharmacist"
//                                 ? "Pharmacy Name"
//                                 : 'Name',
//                             enabled: true,
//                             contentPadding: const EdgeInsets.only(
//                                 left: 14.0, bottom: 8.0, top: 8.0),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Name cannot be empty";
//                             }
//                           },
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           controller: emailController,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: 'Email',
//                             enabled: true,
//                             contentPadding: const EdgeInsets.only(
//                                 left: 14.0, bottom: 8.0, top: 8.0),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value!.length == 0) {
//                               return "Email cannot be empty";
//                             }
//                             if (!RegExp(
//                                     "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
//                                 .hasMatch(value)) {
//                               return ("Please enter a valid email");
//                             } else {
//                               return null;
//                             }
//                           },
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           obscureText: _isObscure,
//                           controller: passwordController,
//                           decoration: InputDecoration(
//                             suffixIcon: IconButton(
//                                 icon: Icon(_isObscure
//                                     ? Icons.visibility_off
//                                     : Icons.visibility),
//                                 onPressed: () {
//                                   setState(() {
//                                     _isObscure = !_isObscure;
//                                   });
//                                 }),
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: 'Password',
//                             enabled: true,
//                             contentPadding: const EdgeInsets.only(
//                                 left: 14.0, bottom: 8.0, top: 15.0),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                           ),
//                           validator: (value) {
//                             RegExp regex = RegExp(r'^.{6,}$');
//                             if (value!.isEmpty) {
//                               return "Password cannot be empty";
//                             }
//                             if (!regex.hasMatch(value)) {
//                               return ("please enter valid password min. 6 character");
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           obscureText: _isObscure2,
//                           controller: confirmpassController,
//                           decoration: InputDecoration(
//                             suffixIcon: IconButton(
//                                 icon: Icon(_isObscure2
//                                     ? Icons.visibility_off
//                                     : Icons.visibility),
//                                 onPressed: () {
//                                   setState(() {
//                                     _isObscure2 = !_isObscure2;
//                                   });
//                                 }),
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: 'Confirm Password',
//                             enabled: true,
//                             contentPadding: const EdgeInsets.only(
//                                 left: 14.0, bottom: 8.0, top: 15.0),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (confirmpassController.text !=
//                                 passwordController.text) {
//                               return "Password did not match";
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           children: [
//                             const Text(
//                               'Select Role',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(width: 30.0),
//                             DropdownButton(
//                               // Initial Value
//                               value: selectedRole,
//
//                               // Down Arrow Icon
//                               icon: const Icon(Icons.keyboard_arrow_down),
//
//                               // Array list of items
//                               items: items.map((String items) {
//                                 return DropdownMenuItem(
//                                   value: items,
//                                   child: Text(
//                                     items,
//                                   ),
//                                 );
//                               }).toList(),
//                               // After selecting the desired option,it will
//                               // change button value to selected value
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   selectedRole = newValue!;
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             // MaterialButton(
//                             //   shape:const RoundedRectangleBorder(
//                             //       borderRadius:
//                             //           BorderRadius.all(Radius.circular(20.0))),
//                             //   elevation: 5.0,
//                             //   height: 40,
//                             //   onPressed: () {
//                             //     const CircularProgressIndicator();
//                             //   },
//                             //   color: Colors.white,
//                             //   child: const Text(
//                             //     "Login",
//                             //     style: TextStyle(
//                             //       fontSize: 20,
//                             //     ),
//                             //   ),
//                             // ),
//                             MaterialButton(
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20.0))),
//                               elevation: 5.0,
//                               height: 40,
//                               onPressed: () {
//                                 setState(() {
//                                   showProgress = true;
//                                 });
//                                 signUp(
//                                   emailController.text,
//                                   passwordController.text,
//                                   nameController.text,
//                                   selectedRole,
//                                 );
//                               },
//                               color: Colors.white,
//                               child: const Text(
//                                 "Register",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 40),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'Already have an account?',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             const SizedBox(width: 20.0),
//                             MaterialButton(
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20.0))),
//                               elevation: 5.0,
//                               height: 36,
//                               onPressed: () async {
//                                 Navigator.of(context).pushReplacement(
//                                     MaterialPageRoute(builder: (context) {
//                                   return SignIn();
//                                 }));
//                               },
//                               color: Colors.white,
//                               child: const Text(
//                                 "Sign Up",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   signUp(String email, String password, String name, String userRole) async {
//     CollectionReference users = FirebaseFirestore.instance.collection('users');
//     if (_formkey.currentState!.validate()) {
//       try {
//         await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         )
//             .then((credential) {
//           users.doc(credential.user!.uid).set({
//             'id': credential.user!.uid.toString(),
//             'full_name': name, // John Doe
//             'role': userRole,
//             'status': UserStatus.active,
//           }).then((value) {
//             Navigator.of(context)
//                 .pushReplacement(MaterialPageRoute(builder: (context) {
//               return SignIn();
//             }));
//           }).catchError((error) => print("Failed to add user: $error"));
//         });
//         setState(() {
//           showProgress = false;
//         });
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'weak-password') {
//           print('The password provided is too weak.');
//         } else if (e.code == 'email-already-in-use') {
//           print('The account already exists for that email.');
//         }
//       } catch (e) {
//         print(e);
//         setState(() {
//           showProgress = false;
//         });
//       }
//     }
//
//     CircularProgressIndicator();
//   }
// }

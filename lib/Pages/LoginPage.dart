import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_map/Pages/SignupPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController pass = TextEditingController();
    final formkey = GlobalKey<FormState>();
    login() async {
      if (formkey.currentState!.validate()) {
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: email.text.trim(), password: pass.text.trim())
              .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Successfully Login !!"))));
          // if (context.mounted) {
          //   Navigator.pop(context);
          // }
        } on FirebaseAuthException catch (e) {
          log(e.toString());
          if (e.code == "invalid-email") {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Invalid Email Address")));
          } else if (e.code == "wrong-password") {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Wrong Password")));
          } else if (e.code == "network-request-failed") {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Network Error")));
          } else if (e.code == "unknown") {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
          } else if (e.code == "user-not-found") {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Create an Account")));
          }
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Welcome",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SvgPicture.asset(
                    "assets/images/login.svg",
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "Enter Your Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 1) {
                        return "Email Can not be Empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: pass,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: "Enter Your Password",
                      prefixIcon: Icon(Icons.password),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      // suffix: IconButton(
                      //   icon: Icon(
                      //     Icons.remove_red_eye,
                      //     size: 15,
                      //   ),
                      //   onPressed: () {
                      //     secure = true;
                      //   },
                      // ),
                    ),
                    onChanged: (value) {
                      setSate() {
                        pass.text = pass.text;
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 1) {
                        return "Password can not be Empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text("Log In"),
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 1, color: Colors.brown),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.only(
                            top: 13, bottom: 13, left: 150, right: 150)),
                    onPressed: () {
                      login();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("or",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Create New Account ? ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ));
                          },
                          child: const Text("Create Account",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

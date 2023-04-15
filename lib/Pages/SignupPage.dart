import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_map/Model/Model.dart';
import 'package:google_map/Pages/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController decp = TextEditingController();
  final formkey = GlobalKey<FormState>();
  createuser() async {
    if (formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text.trim(), password: pass.text)
            .then((value) async {
          Model u = Model(
            address: address.text,
            decp: decp.text,
            email: email.text,
            fullname: fullname.text,
            number: number.text,
            uid: value.user!.uid,
          );
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(u.email)
              .set(u.toMap())
              .onError((e, _) => print("Error writing document: $e"));
        });
        if (context.mounted) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        log(e.toString());
        if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Email Already In Use")));
        } else if (e.code == "weak-password") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Wrong Password")));
        } else if (e.code == "invalid-email") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Invalid Email Address")));
        } else if (e.code == "unknown") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
        } else if (e.code == "operation-not-allowed") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Create Your Account",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
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
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: "Password",
                        hintText: "Enter Your Password",
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a Valid Password";
                      } else if (value.length < 6) {
                        return "Password Should Greater Then 6 Digits";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: fullname,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: "Fullname",
                        hintText: "Enter Your Fullname",
                        prefixIcon: Icon(Icons.abc),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 1) {
                        return "Fullname Can not be Empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: number,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Number",
                        hintText: "Enter Your Number",
                        prefixIcon: Icon(Icons.numbers_rounded),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    validator: (value) {
                      if (value!.isEmpty || value.length != 10) {
                        return "Enter a Valid Number";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: address,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: "Address",
                        hintText: "Enter Your Address",
                        prefixIcon: Icon(Icons.place_rounded),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 1) {
                        return "Address Can not be Empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: decp,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        labelText: "description",
                        hintText: "Enter description About YourSelf",
                        prefixIcon: Icon(Icons.description_rounded),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: const Text("Sign Up"),
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 1, color: Colors.brown),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.only(
                            top: 13, bottom: 13, left: 140, right: 140)),
                    onPressed: () {
                      createuser();
                    },
                  ),
                  const Text("or"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Log In In Older Account ? "),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                          },
                          child: const Text("Log In"))
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

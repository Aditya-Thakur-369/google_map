import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: Center(child: Text("Sign Out")),
        ),
        Text(FirebaseAuth.instance.currentUser!.email!)
      ],
    ));
  }
}

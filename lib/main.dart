import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_map/Pages/Map.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'Backend/Provider.dart';
import 'Pages/HomePage.dart';
import 'Pages/LoginPage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            CardProvider();
          },
        )
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: ThemeData(
          colorSchemeSeed: Colors.blueAccent,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          )),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Navigation();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State {
  int _selectedTab = 0;

  List _pages = [
    Center(
      child: HomePage(),
    ),
    Center(
      child: Text("Saved"),
    ),
    Center(
      child: MapPage(),
    ),
    Center(
      child: Text("Contact"),
    ),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.saved_search), label: "Saved"),
          BottomNavigationBarItem(
            icon: Lottie.network(
                "https://assets5.lottiefiles.com/packages/lf20_9qsh9yze.json",
                height: 42,
                width: 42),
            label: "Map",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notification_add_rounded),
              label: "Notification"),
        ],
      ),
    );
  }
}

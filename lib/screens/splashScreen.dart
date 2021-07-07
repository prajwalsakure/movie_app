import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movies_app/screens/homeScreen.dart';

import 'authScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  @override
  void initState() {
    super.initState();
    initializeUser();
    navigateUser();
    // DatabaseService(userid: _auth.currentUser!.uid).createUserWithEmail(name);
  }

  Future initializeUser() async {
    await Firebase.initializeApp();
    final User firebaseUser = await FirebaseAuth.instance.currentUser!;
    await firebaseUser.reload();
    _user = await _auth.currentUser!;
  }

  navigateUser() async {
    if (_auth.currentUser != null) {
      Timer(
          Duration(seconds: 5),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => homeScreen())));
    } else {
      Timer(
          Duration(seconds: 6),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AuthScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFadingCircle(
              size: 120,
              color: Colors.lightGreenAccent,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "please wait...",
              style: TextStyle(color: Colors.green),
            )
          ],
        )),
      ),
    );
  }
}

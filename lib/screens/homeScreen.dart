import 'dart:async';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/navDrawer/nav_bar.dart';
import 'package:movies_app/screens/authScreen.dart';
import 'package:movies_app/screens/viewAllScreen.dart';
import 'package:movies_app/searchBar/searchBar.dart';
import 'package:movies_app/searchBar/voiceSearch.dart';
import 'package:movies_app/services/dbManager.dart';
import 'package:movies_app/widgets/genre.dart';
import 'package:movies_app/widgets/trendingPerson.dart';

import '../widgets/carousalSlider.dart';

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // String uid = '';
  @override
  void initState() {
    super.initState();
    // uid = _auth.currentUser!.uid;
    // name = _auth.currentUser!.displayName!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: nav_bar(),
        appBar: AppBar(
          title: _auth.currentUser != null
              ? Text(
                  _auth.currentUser!.displayName!,
                  style: TextStyle(color: Colors.black),
                )
              : Text(
                  "User",
                  style: TextStyle(color: Colors.black),
                ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                icon: Icon(Icons.mic),
                // color: Colors.orange,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SpeechSearch()),
                  );
                  // showSearch(context: context, delegate: DataSearch());
                  // search();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                icon: Icon(Icons.search),
                color: Colors.orange,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => search()),
                  );
                  // showSearch(context: context, delegate: DataSearch());
                  // search();
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _auth.currentUser != null
                    ? Container(
                        width: 37.0,
                        height: 37.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                  _auth.currentUser!.photoURL!),
                            )))
                    : Container(
                        width: 37,
                        height: 37,
                        child: Icon(
                          Icons.person,
                          size: 39,
                        )),
              ),
            ),
          ],
          iconTheme: IconThemeData(color: Colors.green),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recomended for you",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                        child: Text(
                          "View All",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewAllScreen(),
                            ),
                          );
                        })
                  ],
                ),
              ),
              carousalSliders(),
              SizedBox(
                height: 10,
              ),
              GenreScroll(),
              SizedBox(
                height: 10,
              ),
              PersonList()
            ],
          ),
        ));
  }
}

// typedef voiceCallback = void Function();

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/firebaseModels/user.dart';
import 'package:movies_app/screens/authScreen.dart';
import 'package:movies_app/screens/favoriteList.dart';
import 'package:movies_app/screens/homeScreen.dart';
import 'package:provider/provider.dart';

class nav_bar extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool data = true;

  @override
  Widget build(BuildContext context) {
    if (data) {
      final userData = Provider.of<UserData>(context);
      final favList = userData.favorites;
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    _auth.currentUser != null
                        ? Text(
                            _auth.currentUser!.displayName!,
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          )
                        : Text(
                            "Side Menu Bar",
                            style: TextStyle(color: Colors.white),
                          ),
                    _auth.currentUser != null
                        ? Image(
                            image: NetworkImage(_auth.currentUser!.photoURL!))
                        : Icon(
                            Icons.person,
                            size: 80,
                          ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://blog.sebastiano.dev/content/images/2019/07/1_l3wujEgEKOecwVzf_dqVrQ.jpeg'),
                  )),
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text('Welcome'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Setting'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.favorite_border_outlined),
              title: Text('Favorites'),
              trailing: Text(
                favList.length.toString(),
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyFavoriteList(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                await googleSignIn.disconnect();
                await googleSignIn.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => homeScreen()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      );
    } else {
      return Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          child: Text(
            'Side Menu',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          decoration: BoxDecoration(
              color: Colors.redAccent,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://blog.sebastiano.dev/content/images/2019/07/1_l3wujEgEKOecwVzf_dqVrQ.jpeg'),
              )),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Setting'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.border_color),
          title: Text('Feedback'),
          onTap: () => {},
        ),
      ]));
    }
  }
}

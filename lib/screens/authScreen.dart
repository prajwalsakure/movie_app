import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/screens/homeScreen.dart';

String name = '';
String email = '';
String imageUrl = '';
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isVisible = false;

  Future<User> _signin() async {
    await Firebase.initializeApp();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    User user = (await _auth.signInWithCredential(credential)).user!;
    if (user != null) {
      name = user.displayName!;
      email = user.email!;
      imageUrl = user.photoURL!;
    }
    return user;
  }

// Stream<User> get user{
//   return _auth.
// }
  @override
  Widget build(BuildContext context) {
    var swidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFB2F2D52)),
                    ),
                    visible: isVisible,
                  )
                ],
              ),
            ],
          ),
          Container(
            // height: 56,
            // margin: const EdgeInsets.only(bottom: 60),
            child: Align(
              alignment: Alignment.center,
              // ignore: deprecated_member_use
              child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      this.isVisible = true;
                    });
                    _signin().whenComplete(() {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => homeScreen()),
                          (Route<dynamic> route) => true);
                    });
                    // .catchError((onError) {
                    //   Navigator.pushReplacementNamed(context, routeName);
                    // });
                  },
                  child: Image(
                    image: AssetImage("assets/sign.png"),
                    width: swidth / 1.4,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //     child: Align(
          //         alignment: Alignment.center,
          //         child: SizedBox(
          //           height: 35,
          //           width: swidth / 1.45,
          //           // ignore: deprecated_member_use
          //           child: RaisedButton(
          //             onPressed: () async {
          //               await FirebaseAuth.instance.signOut();
          //               await googleSignIn.disconnect();
          //               await googleSignIn.signOut();
          //               Navigator.of(context).pushAndRemoveUntil(
          //                   MaterialPageRoute(
          //                       builder: (context) => homeScreen()),
          //                   (Route<dynamic> route) => false);
          //             },
          //             child: Text(
          //               "Logout",
          //               style: TextStyle(fontSize: 16),
          //             ),
          //           ),
          //         )))
        ],
      ),
    );
  }
}

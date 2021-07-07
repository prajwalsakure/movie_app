// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/firebaseModels/user.dart';
import 'package:movies_app/screens/authScreen.dart';
import 'package:movies_app/screens/homeScreen.dart';
import 'package:movies_app/screens/splashScreen.dart';
import 'package:movies_app/screens/viewAllScreen.dart';
import 'package:movies_app/services/dbManager.dart';
import 'package:movies_app/widgets/carousalSlider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// class MainApp extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<UserData>.value(
//         value: DatabaseService().userData,
//         initialData: null,
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: MyApp(),
//         ));
//   }
// }

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // var routes = <String, WidgetBuilder>{
  //   "/auth": (BuildContext context) => AuthScreen(),
  //   "/viewAll": (BuildContext context) => ViewAllScreen()
  // };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
        value: DatabaseService(userid: _auth.currentUser.uid).userData,
        initialData: null,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'My Movie',
            theme: ThemeData(
              primaryColor: Colors.green,
              scaffoldBackgroundColor: Colors.white,
            ),
            home: Scaffold(
              body: SplashScreen(),
            )
            // routes: routes,
            // routes: {
            //   ViewAllScreen.routingName: (context) => ViewAllScreen(),
            // },
            ));
  }
}

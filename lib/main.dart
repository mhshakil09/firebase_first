import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/screens/auth_page/auth_page.dart';
import 'package:firebase_first/screens/home_screen/home_screen.dart';
import 'package:firebase_first/screens/login_screen/login_screen.dart';
import 'package:firebase_first/screens/testing_home_screen/testing_home_screen.dart';
import 'package:firebase_first/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      scaffoldMessengerKey: Helper.messengerKey,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Color(0xFF363636),
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if(snapshot.hasError) {
              return Center(child: Text("something went wrong"),);
            } else if (snapshot.hasData) {
              return TestingHomeScreen();
            } else {
              return AuthPage();
            }
          },
        ),
      ),
    );
  }
}

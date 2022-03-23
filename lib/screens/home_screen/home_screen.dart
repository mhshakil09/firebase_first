import 'package:flutter/material.dart';
import 'package:firebase_first/screens/home_screen/components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: CustomBottomNavigationBar(index: 1),
      appBar: AppBar(
        title: Text("Home"),
      ),
      backgroundColor: Color(0xFF363636),
      body: Body(),
    );
  }
}

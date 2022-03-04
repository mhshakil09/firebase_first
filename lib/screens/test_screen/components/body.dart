import 'package:flutter/material.dart';
import 'package:firebase_first/screens/test_screen/components/background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Container(
        child: Center(
          child: Text(
            "Work in progress",
          ),
        ),
      ),
    );
  }
}

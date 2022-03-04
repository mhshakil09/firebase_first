import 'package:flutter/material.dart';
import 'package:firebase_first/screens/test_screen/components/background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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

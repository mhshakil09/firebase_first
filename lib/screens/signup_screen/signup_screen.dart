import 'package:flutter/material.dart';
import 'package:firebase_first/screens/signup_screen/components/body.dart';

class SignUpScreen extends StatelessWidget {
  final Function onClickedSignIn;
  const SignUpScreen({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363636),
      body: Body(onClickedSignIn: onClickedSignIn),
    );
  }
}

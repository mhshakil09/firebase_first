import 'package:flutter/material.dart';
import 'package:firebase_first/screens/login_screen/components/body.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onClickedSignUp;
  const LoginScreen({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363636),
      body: Body(onClickedSignUp: onClickedSignUp,),
    );
  }
}

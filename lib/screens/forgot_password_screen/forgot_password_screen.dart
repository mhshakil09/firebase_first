import 'package:flutter/material.dart';
import 'package:firebase_first/screens/forgot_password_screen/components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      backgroundColor: Color(0xFF363636),
      body: Body(),
    );
  }
}

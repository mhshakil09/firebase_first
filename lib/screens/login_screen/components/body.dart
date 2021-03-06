import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/main.dart';
import 'package:firebase_first/firebase_firestore/services/authentication_services.dart';
import 'package:firebase_first/utils/helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_first/screens/login_screen/components/background.dart';

class Body extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const Body({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _auth = AuthenticationServices();
  final emailController = TextEditingController();
  final passwordController = TextEditingController(text: 'asdzxc');

  final TextStyle _textStyle = const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.green);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                "Welcome",
                style: _textStyle,
              ),
              Text(
                "to",
                style: _textStyle,
              ),
              Text(
                "FirebaseAuth",
                style: _textStyle,
              ),
              SizedBox(height: 40),
              TextField(
                controller: emailController,keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.blue,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  label: Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4),
              TextField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  label: Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(40)),
                icon: Icon(
                  Icons.lock_open,
                  size: 24,
                ),
                label: Text(
                  'Sign in',
                  style: TextStyle(fontSize: 22),
                ),
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  try {
                    await _auth.signIn(emailController.text.trim(), passwordController.text.trim());
                  } on FirebaseAuthException catch (error) {
                    print("error: "+error.toString());
                    print("error: "+error.code.toString());

                    // Helper.showSnackBar(error.message);
                    Helper.showToastWithDismissible(context, error.message.toString());
                  }
                  navigatorKey.currentState!.popUntil((route) => route.isFirst);

                },
              ),
              SizedBox(height: 40),
              RichText(
                  text: TextSpan(style: TextStyle(color: Colors.white, fontSize: 16), text: "No account? ", children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignUp,
                    text: "Sign up",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ))
              ]))
            ],
          )),
    );
  }


}

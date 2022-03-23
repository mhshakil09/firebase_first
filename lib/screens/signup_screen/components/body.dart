import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/main.dart';
import 'package:firebase_first/firebase_firestore/services/authentication_services.dart';
import 'package:firebase_first/utils/helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_first/screens/signup_screen/components/background.dart';

class Body extends StatefulWidget {
  final Function onClickedSignIn;

  const Body({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formKey = GlobalKey<FormState>();
  final _auth = AuthenticationServices();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
        child: Form(
          key: formKey,
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
              TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  label: Text("Email", style: TextStyle(color: Colors.white)),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) => email != null && !EmailValidator.validate(email)
                    ? 'Enter a valid email'
                    : null,
              ),
              SizedBox(height: 4),
              TextFormField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  label: Text("Password", style: TextStyle(color: Colors.white)),
                ),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) => password != null && password.length < 6
                    ? 'Minimum 6 character is needed'
                    : null,
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(40)),
                icon: Icon(
                  Icons.lock_open,
                  size: 24,
                ),
                label: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 22),
                ),
                onPressed: () {
                  final isValid = formKey.currentState!.validate();
                  if(!isValid) return;

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  try {
                    _auth.signUp(emailController.text.trim(), passwordController.text.trim());
                  } on FirebaseAuthException catch (error) {
                    print(error);
                    Helper.showSnackBar(error.message);
                  }

                  navigatorKey.currentState!.popUntil((route) => route.isFirst);

                },
              ),
              SizedBox(height: 40),
              RichText(
                  text: TextSpan(style: TextStyle(color: Colors.white, fontSize: 16), text: "Already have account? ", children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignIn as GestureTapCallback?,
                    text: "Log in",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ))
              ]))
            ],
          ),
        ),
      ),
    );
  }

}

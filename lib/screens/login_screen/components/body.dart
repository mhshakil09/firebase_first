import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_first/screens/login_screen/components/background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void showToast(String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.redAccent,
      dismissDirection: DismissDirection.horizontal,
      duration: Duration(seconds: 4),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: scaffold.hideCurrentSnackBar,
        textColor: Colors.white,
      ),
    ));
  }

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
              TextField(
                controller: emailController,
                cursorColor: Colors.blue,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(label: Text("Email")),
              ),
              SizedBox(height: 4),
              TextField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(label: Text("Password")),
                obscureText: true,
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(40)),
                icon: Icon(
                  Icons.lock_open,
                  size: 32,
                ),
                label: Text(
                  'Sign in',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: signIn,
              )
            ],
          )),
    );
  }

  Future signIn() async {
    print("Email: ${emailController.text.toString()}");
    print("Password: ${passwordController.text.toString()}");

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (error) {
      showToast(error.message.toString());
      print(error);
      print(error.code);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

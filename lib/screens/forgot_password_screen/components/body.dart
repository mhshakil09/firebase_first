import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/firebase_firestore/services/authentication_services.dart';
import 'package:firebase_first/main.dart';
import 'package:firebase_first/screens/widget/border_animation.dart';
import 'package:firebase_first/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_first/screens/forgot_password_screen/components/background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();

    return Background(
      child: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "In order to reset your password, please provide your Email",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: const InputDecoration(
                    label: Text("Email", style: TextStyle(color: Colors.white)),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) => email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null,
                ),
                const SizedBox(height: 20),
                BorderAnimationRound(
                  height: 50,
                  width: 150,
                  duration: 4,
                  borderColor: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        print('password reset, requested...');
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                        try {
                          await AuthenticationServices().resetPassword(emailController.text.trim());
                          Helper.showSnackBar("Password reset Email has been sent");
                        } on FirebaseAuthException catch (error) {
                          print(error);
                          Helper.showToastWithDismissible(context, error.message.toString());
                        }
                        navigatorKey.currentState!.popUntil((route) => route.isFirst);
                      },
                      icon: Icon(Icons.email),
                      label: const Text(
                        "submit",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // child: Container(
                    //   decoration: const BoxDecoration(
                    //     color: Colors.blue,
                    //   ),
                    //   alignment: Alignment.center,
                    //   child: const Text(
                    //     "submit",
                    //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/firebase_firestore/database_manager/firestore_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthenticationServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    print("Email: ${email}");
    print("Password: ${password}");

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }

    // await FirestoreManager().createTestInputData(email, password, _auth.currentUser!.uid, "100");
  }

  Future signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }
}

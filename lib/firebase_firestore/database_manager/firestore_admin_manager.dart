import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreAdminManager {
  final CollectionReference adminList = FirebaseFirestore.instance.collection('adminList');
  final CollectionReference employeeList = FirebaseFirestore.instance.collection('employeeList');

  Future isAdminCheck(String uid) async {

    DocumentSnapshot snapshot;

    try {
      snapshot = await adminList.doc(uid).get();
      print("isAdminCheck");
      if(snapshot.exists) {
        print("isAdmin: "+snapshot.exists.toString());
        return true;
      } else {
        print("isAdmin: "+snapshot.exists.toString());
        return false;
      }
    } catch (error) {
      print("error: "+error.toString());
      return false;
    }
  }
}
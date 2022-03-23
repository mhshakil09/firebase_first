import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_first/firebase_firestore/database_manager/firestore_admin_manager.dart';
import 'dart:developer';

import 'package:flutter/foundation.dart';

class FirestoreManager {
  // final CollectionReference profileList = FirebaseFirestore.instance.collection('employeeList');
  final CollectionReference profileList = FirebaseFirestore.instance.collection('testInputData');

  Future<void> createTestInputData(String email, String password, String uid, String data) async {
    return await profileList.doc(uid).set({'name': email, 'password': password, 'data': data});
  }

  Future<void> editTestInputData(String password, String uid) async {
    return await profileList.doc(uid).update({'password': password});
  }

  Future getTestInputDataList(String uid) async {
    List items = [];

    try {
      await profileList.get().then((querySnapshot) => {
            querySnapshot.docs.forEach((element) {
              print("++++++++++");
              print(element.data());
              items.add(element.data());
            })
          });
      return items;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future getTestInputData(String uid) async {
    List items = [];
    DocumentSnapshot snapshot;
    try {
      print("----------------getTestInputData----------------");
      print(uid);
      snapshot = await profileList.doc(uid).get();
      print("----------------");
      print(snapshot.data());
      items.add(snapshot.data());
      print("----------------");
      // print(snapshot.data());

      // getTestInputDataTesting(uid); // ToDo remove this, this is for testing purpose
      // getTestMultiLevelData(uid); // ToDo remove this, this is for testing purpose
      // getTestNestedData(uid); // ToDo remove this, this is for testing purpose
      FirestoreAdminManager().isAdminCheck(uid); // ToDo remove this, this is for testing purpose

      return items;
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future getTestInputDataTesting(String uid) async {
    List items = [];
    QuerySnapshot snapshot;
    try {
      print("----------------getTestInputDataTesting----------------");
      print(uid);
      snapshot = await FirebaseFirestore.instance.collection('testInputData').get();
      print("----------------");
      print(snapshot);
      print("----------------");
      print(snapshot.docs);
      print("----------------");
      print(snapshot.docs.length);
      print("----------------");
      for (var item in snapshot.docs.toList()) {
        print("++++++++++++++++");
        Map a = {"id": item.id, "data": item["data"], "name": item["name"], "password": item["password"]};
        print(a);
        items.add(a);
      }
      print("----------------getTestInputDataTesting----------------");
      for (int i = 0; i < items.length; i++) {
        print(items[i]);
      }
      print("----------------getTestInputDataTesting----------------");
      print(items);
      print("----------------getTestInputDataTesting----------------");
      // print(snapshot.data());
      return items;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  Future getTestMultiLevelData(String uid) async {

    List items = [];
    QuerySnapshot snapshot;
    QuerySnapshot snapshotTesting;
    QuerySnapshot snapshotDocsCollection;
    DocumentSnapshot snapshotDoc;

    try {
      print("----------------getTestInputDataTesting----------------");
      print(uid);
      snapshot = await FirebaseFirestore.instance.collection('testMultiLevelData').get();
      // print("----------------");
      // print(snapshot);
      // print("----------------");
      // print(snapshot.docs);
      print("----------------");
      print(snapshot.docs.length);
      print("----------------");
      for (var item in snapshot.docs.toList()) {
        print("++++++++++++++++");
        // Map a = {"id": item.id, "data": item["data"], "name": item["name"], "password": item["password"]};
        Map a = {"id": item.id};
        print(a);
        items.add(a);
      }


      print('-----------------');
      snapshotTesting = await FirebaseFirestore.instance.
      collection('testMultiLevelData').doc('1001').
      collection('educationInformation').get();

      for ( var item in snapshotTesting.docs.toList()) {
        print(item.data());
        Map a = {"id": item.id, "gpa": item['gpa'], 'passingYear' : item['passingYear']};
        print('*********');
        // print(a);
        // print(a['gpa']);
        // print(a['passingYear']);

        /// testing in progress-------------------------
        // snapshotDocsCollection = await FirebaseFirestore.instance.
        // collection('testMultiLevelData').doc('1001').
        // collection('educationInformation').doc(item.id).
        // collection('institutionInformation').get();
        //----------------------------------------------

        /// testing in progress-------------------------
        snapshotDocsCollection = await FirebaseFirestore.instance.
        collection('testMultiLevelData/1001/educationInformation/${item.id}/institutionInformation').
        get();
        //----------------------------------------------

        snapshotDoc = await FirebaseFirestore.instance.
        collection('testMultiLevelData/1001/educationInformation/${item.id}/institutionInformation').
        doc(snapshotDocsCollection.docs.toList().first.id).get();
        print(snapshotDoc.data());
        print('*********');
        // print(snapshotDoc['name']);
      }
      print('-----------------');
      print("----------------getTestInputDataTesting----------------");
      // for (int i = 0; i < items.length; i++) {
      //   print(items[i]);
      // }
      print("----------------getTestInputDataTesting----------------");
      print(items);
      print("----------------getTestInputDataTesting----------------");
      // print(snapshot.data());
      return items;

    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  Future getTestNestedData(String uid) async {
    uid = '1002';
    
    var fireStore = FirebaseFirestore.instance.collection('testMultiLevelData');
    
    List items = [];
    QuerySnapshot querySnapshot = await fireStore.get();
    DocumentSnapshot documentSnapshot = await fireStore.doc(uid).get();


    // await FirebaseFirestore.instance.
    // collection('testMultiLevelData').doc('1001').
    // collection('educationInformation').get();

    // print(querySnapshot.size);

    // print('-----------------');
    // for (var item in querySnapshot.docs.toList()) {
    //   print(item.id);
    // }
    // print('-----------------');

    print('*****************************');
    print(documentSnapshot.id);
    documentSnapshot = await fireStore.doc(uid).get();
    print(documentSnapshot.data());
    print('*****************************');
    querySnapshot = await fireStore.doc(uid).collection('education').get();
    print('-----------------');
    for (var item in querySnapshot.docs.toList()) {
      print('+++++++');
      print(item.id);
      print(item['passingYear']);
    }
    print('-----------------');

  }
}

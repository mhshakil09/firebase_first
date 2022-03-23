import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/firebase_firestore/database_manager/firestore_manager.dart';
import 'package:firebase_first/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_first/screens/home_screen/components/background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    int count = 1;

    return Background(
        child: Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Signed in as",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            user.email!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "id: " + user.uid,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            icon: Icon(Icons.arrow_back, size: 32),
            label: Text(
              "Logout",
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
          SizedBox(height: 8),
          IconButton(
            icon: Icon(Icons.refresh, size: 32, color: Colors.cyan,),
            onPressed: () async {
              FirestoreManager().createTestInputData(user.email!, 'asdzxc', user.uid, count.toString());

              var response = await FirestoreManager().getTestInputDataList(user.uid);
              print("--------------");
              print(response[0]);
              print("--------------");
              print(response[0]['name']);
              print("--------------");

              // var response = await FirestoreManager().getTestInputData(user.uid);
              // print("--------------");
              // print(response);
              // print("--------------");
              // print(response['name']);
              // print("--------------");

              Helper.showSnackBar(count.toString());
              count++;
            },
          ),
        ],
      ),
    ));
  }
}

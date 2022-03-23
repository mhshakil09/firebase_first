import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/firebase_firestore/database_manager/firestore_manager.dart';
import 'package:firebase_first/main.dart';
import 'package:firebase_first/screens/widget/glowing_button.dart';
import 'package:firebase_first/screens/widget/item_emp.dart';
import 'package:firebase_first/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_first/screens/displaydata_screen/components/background.dart';

class Body extends StatefulWidget {
  final Color color1;
  final Color color2;

  const Body({Key? key, this.color1 = Colors.cyan, this.color2 = Colors.greenAccent}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final user = FirebaseAuth.instance.currentUser!;
  var textEditingController = TextEditingController();
  var _isSpinner = false;

  List employeeList = [];

  // late Map<String, dynamic> snapshotData;

  Future<DocumentSnapshot> getTestData() async {
    try {
      // var snapshot = await FirestoreManager().getTestInputData(user.uid);
      return await FirestoreManager().getTestInputData(user.uid);
      // print("////////////////////////");
      // snapshotData = snapshot;
      // print(snapshot);
      // print(snapshot['name']);
      // print(snapshotData['name']);
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  fetchEmployeeData() async {
    QuerySnapshot querySnapshot;
    _isSpinner = true;
    querySnapshot = await FirebaseFirestore.instance.collection('employeeList').get();
    // querySnapshot = await FirebaseFirestore.instance.collection('adminList').get();
    setState(() {
      _isSpinner = false;
    });
    print("EmployeeCount: " + querySnapshot.size.toString());

    for (var item in querySnapshot.docs.toList()) {
      // Map a = {"id": item.id, "email": item["email"], "isAdmin": item["isAdmin"]};
      Map a = {
        "id": item.id,
        "email": item["email"],
        "name": item["name"],
        'phone_number': item['phone_number'],
        'image_link': item['image_link'],
      };
      print(a);
      employeeList.add(a);
    }
    print(employeeList);
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchEmployeeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var glowing = false;
    var scale = 1.0;

    return Background(
      child: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: size.height,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: employeeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemEmployee(employeeList[index], employeeList.length, index);
                          // return ItemEmployee(employeeList.length, index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Visibility(
                visible: _isSpinner,
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// const SizedBox(height: 20),
// GlowingButton(
//   height: 50,
//   width: 150,
//   text: 'Submit',
//   textStyle: TextStyle(color: Colors.white, fontSize: 24),
//   onPressed: () async {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//
//     try {
//       await FirestoreManager().editTestInputData(
//         // user.email.toString(),
//         textEditingController.text.trim(),
//         user.uid,
//         // '1002'
//       );
//       Helper.showSnackBar("Data updated");
//     } on FirebaseAuthException catch (error) {
//       print(error);
//       Helper.showToastWithDismissible(context, error.message.toString());
//     }
//
//     navigatorKey.currentState!.popUntil((route) => route.isFirst);
//   },
//   icon: Icons.send,
//   iconPositionLast: false,
//   color1: Colors.blue,
//   color2: Colors.greenAccent,
// ),

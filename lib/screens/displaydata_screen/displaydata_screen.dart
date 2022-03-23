import 'package:flutter/material.dart';
import 'package:firebase_first/screens/displaydata_screen/components/body.dart';

class DisplayDataScreen extends StatelessWidget {
  const DisplayDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
      ),
      backgroundColor: Color(0xFF363636),
      body: Body(),
    );
  }
}

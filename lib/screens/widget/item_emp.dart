import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class ItemEmployee extends StatefulWidget {
  final employee;
  final int length;
  final int index;

  const ItemEmployee(this.employee, this.length, this.index, {Key? key}) : super(key: key);

  @override
  State<ItemEmployee> createState() => _ItemEmployeeState(employee, length, index);
}

class _ItemEmployeeState extends State<ItemEmployee> {
  _ItemEmployeeState(this.employee, this.length, this.index);

  var employee;
  int length;
  int index;

  //to show base64 Image
  Image loadImage() {
    String _base64 =
        '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';
    Uint8List _bytes = Base64Decoder().convert(_base64);

    return Image.memory(_bytes);
  }

  Future<void> _makePhoneCall(String url) async {
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  // color: employee.employeeAvailability == 0 ? Colors.grey : Color(0xFF00BEA0),
                  color: Color(0xFF00BEA0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(width: 10.0),
                    Container(
                      width: 60,
                      height: 60,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      // child: loadImage(),
                      child: employee['image_link'].isNotEmpty && employee['image_link'] != null
                          ? Image.network(
                              employee['image_link'],
                              alignment: Alignment.center,
                            )
                          : loadImage(),
                          // : Image.asset(
                          //     'assets/images/profile_image.png',
                          //     alignment: Alignment.center,
                          //   ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              employee['name'].toString(),
                              // "test",
                              style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              // employee.employeeDesignation.toString(),
                              "test",
                              style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF44918E),
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        height: 40.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.tealAccent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                          color: Colors.tealAccent,
                        ),
                        child: Icon(
                          Icons.call,
                          color: Color(0xFF44918E),
                          size: 25.0,
                        ),
                      ),
                      onTap: () async {
                        /*
                          * tel:<phone number>,
                          * e.g. tel:+1 555 010 999
                          * */
                        // String tempPhoneNumber = 'tel:' + employee.employeePhoneNumber.toString();
                        setState(() {
                          // _makePhoneCall(tempPhoneNumber);
                          // _makePhoneCall('tel:+8801676100969');
                        });
                      },
                    ),
                    const SizedBox(width: 10.0),
                  ],
                ),
              ),
            ),
            if (length == index + 1)
              const SizedBox(
                height: 30.0,
              ),
          ],
        ),
      ),
      onTap: () {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     duration: const Duration(seconds: 2),
        //     backgroundColor: Colors.tealAccent,
        //     content: Text(
        //       employee.employeeName.toString(),
        //       style: TextStyle(
        //         color: Colors.black,
        //       ),
        //     ),
        //   ),
        // );

        // Navigator.push(
        //   context,
        //   MaterialPageRoute<void>(
        //     builder: (context) {
        //       return EmployeeDetailsScreen(widget.employee);
        //     },
        //   ),
        // );
      },
    );
  }
}

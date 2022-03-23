import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/firebase_firestore/database_manager/firestore_admin_manager.dart';
import 'package:firebase_first/screens/displaydata_screen/displaydata_screen.dart';
import 'package:firebase_first/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:firebase_first/screens/home_screen/home_screen.dart';
import 'package:firebase_first/screens/login_screen/login_screen.dart';
import 'package:firebase_first/screens/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';

class TestingHomeScreen extends StatefulWidget {
  const TestingHomeScreen({Key? key}) : super(key: key);

  @override
  State<TestingHomeScreen> createState() => _TestingHomeScreenState();
}

class _TestingHomeScreenState extends State<TestingHomeScreen> {
  int index = 1;
  bool isAdmin = false;
  final user = FirebaseAuth.instance.currentUser!;
  GlobalKey<CurvedNavigationBarState> curvedBottomNavigationBar = GlobalKey();

  Future<bool> isAdminCheck() async {
    var adminLevel = await FirestoreAdminManager().isAdminCheck(user.uid);
    setState(() {
      isAdmin = adminLevel;
    });
    return isAdmin;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAdminCheck();
  }

  @override
  Widget build(BuildContext context) {
    bool showBottomNavigation = true;

    var screens = isAdmin
        ? [
            DisplayDataScreen(),
            HomeScreen(),
            ForgotPasswordScreen(),
          ]
        : [
            DisplayDataScreen(),
            HomeScreen(),
          ];

    var screensAdmin = [
      DisplayDataScreen(),
      HomeScreen(),
      ForgotPasswordScreen(),
    ];

    var itemsAdmin = [
      const Icon(Icons.account_circle, size: 30),
      const Icon(Icons.home, size: 30),
      const Icon(Icons.fiber_new, size: 30),
    ];

    var items = isAdmin
        ? [
            const Icon(Icons.account_circle, size: 30),
            const Icon(Icons.home, size: 30),
            const Icon(Icons.fiber_new, size: 30),
          ]
        : [
            const Icon(Icons.account_circle, size: 30),
            const Icon(Icons.home, size: 30),
          ];

    // var screens = [
    //   DisplayDataScreen(),
    //   HomeScreen(),
    // ];
    //
    // var items = [
    //   const Icon(Icons.account_circle, size: 30),
    //   const Icon(Icons.home, size: 30),
    // ];

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: Color(0xFF363636),
        bottomNavigationBar: showBottomNavigation
            ? Theme(
                data: Theme.of(context).copyWith(iconTheme: IconThemeData(color: Colors.white)),
                child: CurvedNavigationBar(
                  key: ValueKey(isAdmin),
                  color: Colors.blue,
                  buttonBackgroundColor: Colors.green,
                  items: items,
                  index: index,
                  height: 50,
                  backgroundColor: Colors.transparent,
                  onTap: (index) => setState(() {
                    this.index = index;
                    print(index);
                  }),
                ),
              )
            : SizedBox.shrink(),
        body: screens[index],
      ),
    );
  }
}

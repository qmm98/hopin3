// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_app/screens/LoginScreen.dart';
import 'package:flutter_app/screens/MyApp.dart';
import 'package:flutter_app/services/Authenticator.dart';
import 'package:flutter_app/services/DataBase.dart';
import 'package:flutter_app/services/themes.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  static final _auth = Authenticator();
  final db = DataBase(auth: _auth);
  bool isAuthenticated;

  void printCurrentUserData() async {
    var currentUser = await _auth.getCurrentFireBaseUserID();
    print('user is $currentUser');
  }

  void navigateToCorrectPage() async {
    isAuthenticated = await _auth.isUserAuthenticated();
    if (isAuthenticated) {
      print('navigating to APP!!!');
      var currentUser = await _auth.getCurrentFireBaseUser();
      //var currentDB = DataBase(auth: _auth);
      await Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(
              db: db,
              selectedIndex: 0,
            ),
          ),
        );
      });
    } else {
      print("navigating to Login");
      await Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(
              db: db,
            ),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print('inside init state...');
    //printCurrentUserData();
    navigateToCorrectPage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: themes.lighttheme,
      darkTheme: themes.darktheme,
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HopIn',
              style: TextStyle(fontSize: 35),
            ),
            Text(
              'Traveling made easy!',
              style: TextStyle(fontSize: 30, color: Colors.redAccent),
            )
          ],
        )),
      ),
    );
  }
}

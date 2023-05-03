// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_app/services/themes.dart';

class ConfirmScreen extends StatelessWidget {
  var darkBlueColor = Color.fromRGBO(26, 26, 48, 1.0);
  var lightBlueColor = Colors.blue;
  var lightGreyBackground = Color.fromRGBO(229, 229, 229, 1.0);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HopIn',
        themeMode: ThemeMode.system,
        theme: themes.lighttheme,
        darkTheme: themes.darktheme,
        home: Scaffold(
          body: SafeArea(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 10.0),
                      child: Text(
                        "Share My Ride",
                        style: TextStyle(fontSize: 50.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30.0, top: 50.0),
                      child: Text(
                        "Confirm",
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                      child: TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter your confirmation code"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 50.0, bottom: 80.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Confirm",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              backgroundColor: darkBlueColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 130.0,
                          child: Image.asset(
                            'assets/images/login_icon.png',
                            color: darkBlueColor,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

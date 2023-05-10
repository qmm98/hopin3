// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/UserModel.dart';
import 'package:flutter_app/screens/AuthScreen.dart';
import 'package:flutter_app/screens/ProfileEditScreen.dart';
import 'package:flutter_app/services/Authenticator.dart';
import 'package:flutter_app/services/DataBase.dart';
import 'package:flutter_app/services/themes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class LoginScreen extends StatefulWidget {
  final DataBase db;
  static var v1;

  LoginScreen({@required this.db});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneInput;

  TextEditingController phonenumtext = TextEditingController();

  TextEditingController code = TextEditingController();

  String s1 = 'Rider';

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
                        "SignIn",
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                      child: SignInButton(
                          buttonType: ButtonType.google,
                          onPressed: () async {
                            var result = await Authenticator().signinwgoogle();
                            if (result == null) {
                              print('problem with registationn :(((((((((((');
                            } else {
                              //If no problems with sing in go to profileScreen to enter data
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileEditScreen(
                                      db: widget.db, isNewUser: true),
                                ),
                              );
                            }
                          }),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 25),
                            child: Text('+92 ')),
                        Container(
                          padding: EdgeInsets.only(
                              left: 55.0, right: 20.0, top: 10.0),
                          child: TextFormField(
                            controller: phonenumtext,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Login with phone number',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 50.0, bottom: 80.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              UserModel().isdriver == s1;
                              await Authenticator()
                                  .signinwithphone(phonenumtext.text);

                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: new Text('Enter OTP'),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      content: new SizedBox(
                                        //height: 300,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 20.0,
                                                  right: 20.0,
                                                  top: 10.0),
                                              child: TextFormField(
                                                controller: code,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText:
                                                      'verification code',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        // TextButton(
                                        //   child: Text("Resend Code"),
                                        //   onPressed: () {},
                                        // ),
                                        TextButton(
                                          child: Text("Confirm"),
                                          onPressed: () async {
                                            var v1 = await Authenticator()
                                                .verifyphone(code.text);

                                            if (v1 != null) {
                                              LoginScreen.v1 =
                                                  phonenumtext.text;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfileEditScreen(
                                                          db: widget.db,
                                                          isNewUser: true),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  });

                              //await DataBase().isdriver(s1);
                            },
                            child: Column(
                              children: [
                                Text(
                                  "Next",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              backgroundColor: darkBlueColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 50.0, bottom: 80.0, left: 20),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                backgroundColor: darkBlueColor,
                              ),
                              onPressed: () {
                                if (s1 == 'Rider') {
                                  setState(() {
                                    s1 = 'Driver';
                                  });
                                } else {
                                  setState(() {
                                    s1 = 'Rider';
                                  });
                                }
                              },
                              child: Text(
                                s1,
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 25.0, 8.0, 0.0),
                          child: InkWell(
                            onTap: () async {
                              var result = await widget.db.auth
                                  .getAnonUserSingInResult();
                              if (result == null) {
                                print('problem with registationn :(((((((((((');
                              } else {
                                //If no problems with sing in go to profileScreen to enter data
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileEditScreen(
                                        db: widget.db, isNewUser: true),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Sign in anonymously',
                              style: TextStyle(
                                color: darkBlueColor,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/AuthScreen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await requestpermissions();
  runApp(Welcome());
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

requestpermissions() async {
  var status = await Permission.location.status;
  if (status.isGranted) {
  } else if (status.isDenied) {
    if (await Permission.location.request().isGranted) {
      print('.......permission granted');
    }
  } else if (status.isPermanentlyDenied) {
    await openAppSettings();
  } else {}
}

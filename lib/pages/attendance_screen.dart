import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AttendanceScreen extends StatelessWidget {
  FirebaseUser auth;

  AttendanceScreen(this.auth);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Text(auth.toString() ),
      ),
    );
  }
}

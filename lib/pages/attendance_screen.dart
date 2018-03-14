import 'package:attendance_assistant/pages/live_help.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AttendanceScreen extends StatelessWidget {
//  FirebaseUser auth;
//  AttendanceScreen(this.auth);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('Mark Attendance'),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.help),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new LiveHelp()));
              },
            ),
          ],
        ),
        body: new Container(

        //child: new Text(prefs.getString('email')),
      ),
    );
  }
}
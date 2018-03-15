import 'dart:async';

import 'package:attendance_assistant/pages/live_help.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AttendanceScreen extends StatefulWidget {

  @override
  AttendanceScreenState createState() => new AttendanceScreenState();

}

class AttendanceScreenState extends State<AttendanceScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//  Future getCookie() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String email = prefs.getString('email');
//    debugPrint(email.toString());
//    return email;
//  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
              title: new Text("Attendance Page"),
              actions: <Widget>[
                new IconButton(
                    icon: new Icon(Icons.help),
                    onPressed: () {
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new LiveHelp()  ));
                    }
                ),
              ],
          ),
          drawer: new Drawer(
            child: new Column(
              children: <Widget>[

                new UserAccountsDrawerHeader(
                    accountName: null,
                    accountEmail:
                    new FutureBuilder<SharedPreferences>(
                        future: _prefs,
                        builder: (BuildContext context,
                            AsyncSnapshot<SharedPreferences> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting)
                            return const Text('Loading...');
                          final String email = snapshot.requireData.getString('email') ?? '';
                          return new Text(email);
                        }),
                )
              ],
            ),
          ),
        )
    );
  }

}

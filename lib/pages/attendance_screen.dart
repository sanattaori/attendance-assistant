import 'dart:async';

import 'package:attendance_assistant/pages/live_help.dart';
import 'package:attendance_assistant/pages/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AttendanceScreen extends StatefulWidget {


  @override
  AttendanceScreenState createState() => new AttendanceScreenState();

}

class AttendanceScreenState extends State<AttendanceScreen> with TickerProviderStateMixin{
  int total = 100;
  bool ctap = false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
          appBar: new AppBar(
              title: new Text("Manual Attendance"),
              actions: <Widget>[
                new IconButton(
                    icon: new Icon(Icons.help),
                    onPressed: () {
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new LiveHelp()  ));
                    }
                ),
              ],
          ),
          body:
          new GridView.count(
            crossAxisCount: 5,
            // Generate 100 Widgets that display their index in the List
            children: new List.generate(total, (_index) {

              return new Stack(

                children: <Widget>[

                  new Material(
                    //color: ctap?  Colors.red : Colors.green,
                    child: new InkWell(

                      highlightColor: Colors.green,
                      onLongPress: () {


                      },
//                    new Icon(Icons.verified_user),
                      child: new Center(
                        child: new Text(
                          (_index+1).toString(),
                        ),
                      ),
                    ),
                  ),
                  //new Padding(padding: new EdgeInsets.only(top: 30.0)),
                  new Icon(Icons.person,size: 30.0,color: ctap ? Colors.green : Colors.red,),

                ],
              );
            }),
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
                        }
                        ),
                ),
                new MaterialButton(onPressed: (){
                  getCookie();
                }, child: new Text('Logout',textAlign: TextAlign.left,)),
              ],
            ),
          ),
        );
  }

  Future getCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', null);
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => new Onboarding()));
    //debugPrint(cookie.toString());
  }

}

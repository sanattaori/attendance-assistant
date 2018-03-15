import 'package:attendance_assistant/pages/live_help.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {

  @override
  AttendanceScreenState createState() => new AttendanceScreenState();

}
class AttendanceScreenState extends State<AttendanceScreen> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        routes: <String, WidgetBuilder>{
          '/LiveHelp': (BuildContext context) => new LiveHelp(),
        },
        home: new Scaffold(
          appBar: new AppBar(
              title: new Text("Attendance Page"),
              actions: <Widget>[
                new IconButton(
                    icon: new Icon(Icons.help),
                    onPressed: () {
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new LiveHelp()));
                    }
                ),
              ],
          ),
        )
    );
  }

}

import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            width: double.infinity,
            color: Colors.blue,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                    padding: new EdgeInsets.only(bottom: 25.0)),

                new Icon(Icons.person ,size: 50.0,),
                new Padding(
                    padding: new EdgeInsets.only(bottom: 25.0)),

                new Text(
                  'Transforming Attendance System',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                    color: Colors.white,

                    fontFamily: 'FlamanteRoma',
                    fontSize: 34.0,

                  ),
                ),
                new Padding(
                    padding: new EdgeInsets.only(bottom: 10.0,top: 10.0)),

                new Text(
                  'Store Attendance data securely in your digital account',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,

                  ),
                ),
                new Padding(padding: new EdgeInsets.only(bottom: 85.0))

              ],
            ),
          ),

        ],
      ),
    );
  }

}
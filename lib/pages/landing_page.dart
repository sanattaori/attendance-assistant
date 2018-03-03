import 'package:flutter/material.dart';
import 'package:attendance_assistant/pages/sign_in_page.dart';
import 'package:attendance_assistant/pages/signup_page.dart';

class LandingPage extends StatelessWidget {

  int value;


  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Expanded(
            child: new Material(
              color: Colors.yellowAccent,
              // ignore: invocation_of_non_function
              child: new InkWell(
                onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SignupPage())),
                child: new Center(
                  child: new Container(
                      child: new Icon(Icons.verified_user, size: 90.0)
                  ),
                ),
              ),
            )
            ),

            new Expanded(
                child: new Material(
                  color: Colors.deepOrangeAccent,
                  // ignore: invocation_of_non_function
                  child: new InkWell(
                    onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SignupPage())),
                    child: new Center(
                      child: new Container(
                          child: new Icon(Icons.supervised_user_circle, size: 90.0)
                      ),
                    ),
                  ),
                )
            ),
          ],
        )
      ],
    );
  }
}
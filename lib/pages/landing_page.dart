import 'package:flutter/material.dart';
import 'package:attendance_assistant/pages/sign_in_page.dart';
import 'package:attendance_assistant/pages/signup_page.dart';

class LandingPage extends StatelessWidget {
//  var routes = <String, WidgetBuilder> {
//    "/signup_page": (BuildContext context) => new SignupPage()
//  };
  int value;


  @override
  Widget build(BuildContext context) {
    //hero image
    var decoratedBox = new DecoratedBox(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            fit: BoxFit.fitWidth,
            image: new AssetImage('assets/logos/professor.jpg'),
          ),
          shape: BoxShape.circle,
        )
    );

    // hero top left
    var hero = new Hero(
      tag: 'hero-tag-llama',
      child: decoratedBox,
    );

    var _children = <Widget>[
      new Container(
        height: 50.0,
        width: 50.0,
        child: hero,
      ),
    ];


    return new Stack(
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Expanded(
            child: new Material(
              color: Colors.yellowAccent,
              // ignore: invocation_of_non_function
              child: new InkWell(
                onTap: ()=>  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SignupPage())),
                child: new Center(
                  child: new Container(
                      child: new Column(
                        
                      ),
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
                    onTap: ()=>  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SignupPage())),
                    child: new Center(
                      child: new Container(
                          child: new Column(
                            children: _children,
                          )
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
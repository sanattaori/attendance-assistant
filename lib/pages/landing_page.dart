import 'package:flutter/material.dart';
//import 'package:attendance_assistant/pages/sign_in_page.dart';
import 'package:attendance_assistant/pages/signup_page.dart';

class LandingPage extends StatelessWidget {
//  var routes = <String, WidgetBuilder> {
//    "/signup_page": (BuildContext context) => new SignupPage()
//  };
  //int value;


  @override
  Widget build(BuildContext context) {
    //hero image
    var decoratedBox = new DecoratedBox(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            fit: BoxFit.fitWidth,
            image: new AssetImage('assets/logos/stu.jpg'),
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
      new Center(
        child: new Container(
          height: 150.0,
          width: 150.0,
          child: hero,
        ),
      ),
    ];

    var decoratedBox2 = new DecoratedBox(

        decoration: new BoxDecoration(
          image: new DecorationImage(
            fit: BoxFit.fitWidth,
            image: new AssetImage('assets/logos/professor.jpg'),
          ),
          shape: BoxShape.circle,
        )
    );


    // hero top left
    var hero2 = new Hero(
      tag: 'hero-tag-llama2',
      child: decoratedBox2,
    );

    var _children2 = <Widget>[
      new Center(
        child: new Container(
          height: 150.0,
          width: 150.0,
          child: hero2,
        ),
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
                onTap: ()=>  Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => new SignupPage(value: 2,))),
                child: new Center(
                  child: new Container(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _children,
                      ),
                  ),
                ),
              ),
            )
            ),
            new Material(
              color:  Colors.blueGrey,
              child: new Center(
                child: new Padding(
                  padding: new EdgeInsets.all(20.0),
                  child: new Center(
                    child: new Text("Select Role" ,
                      style: new TextStyle(fontSize: 25.0),
                    ),
                  ),
                ),
              ),
            ),
            new Expanded(
                child: new Material(
                  color: Colors.deepOrangeAccent,
                  // ignore: invocation_of_non_function
                  child: new InkWell(
                    onTap: ()=>  Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => new SignupPage(value: 1,))),
                    child: new Center(
                      child: new Container(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _children2,
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
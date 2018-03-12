import 'dart:async';
import 'package:attendance_assistant/pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO : (Ravi) Modify new assets images and hero icons
final pages = [
  new PageViewModel(
      const Color(0xFFF57C00),
      'assets/ob/img_ob_att.png',
      'Transforming Attendance System',
      'Now taking Attendance made easy, Store and manage Attendance data securly stored in digital account',
      'assets/ob/img_ob_att.png',
      false
  ),
  new PageViewModel(
      const Color(0xFF65B0B4),
      'assets/ob/img_ob_att.png',
      'Build for Students and Teachers',
      'Directly Share Class Notes and materials, helping student share code and get guidance',
      //TODO : add more content
      'assets/ob/img_ob_att.png',
      false
  ),
  new PageViewModel(
    const Color(0xFF8E24AA),
    'assets/ob/img_ob_att.png',
    'Easily Track attendance',
    'Detailed Analysis made and Statics report avaliable even save as xml offine',
    'assets/ob/img_ob_att.png',
    true
  ),
];

class Page extends StatelessWidget {

  PageViewModel viewModel;
  final double percentVisible;

  Page({
    this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {

    return new Container(
      padding: new EdgeInsets.all(25.0),
        width: double.INFINITY,
        color: viewModel.color,
        child: new Opacity(
          opacity: percentVisible,
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Transform(
                  transform: new Matrix4.translationValues(0.0, 50.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(bottom: 25.0),
                    child: new Image.asset(
                        viewModel.heroAssetPath,
                        width: 200.0,
                        height: 200.0
                    ),
                  ),
                ),
                new Transform(
                  transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: new Text(
                      viewModel.title,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'FlamanteRoma',
                        fontSize: 34.0,
                      ),
                    ),
                  ),
                ),
                new Transform(
                  transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(bottom: 30.0),
                    child: new Text(
                      viewModel.body,
                      
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),

                new Transform(
                  transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
                  child:
                    viewModel.val ? new RaisedButton(
                      onPressed: () {
                        loadOnce();
                        Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => new LandingPage()));
                        },
                      child: new Text('Get Started!'),
                    ): null,
                  ),
              ]
          ),
        )
    );
  }

  Future loadOnce() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('LoadOB', true);
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;
  final bool val;

  PageViewModel(
      this.color,
      this.heroAssetPath,
      this.title,
      this.body,
      this.iconAssetPath,
      this.val,

      );
}
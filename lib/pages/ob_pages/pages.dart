import 'package:flutter/material.dart';
//TODO : (Ravi) Modify new assets images and hero icons
final pages = [
  new PageViewModel(
      const Color(0xFF678FB4),
      'assets/ob/img_ob_att.png',
      'Transforming Attendance System',
      'Now taking Attendance made easy, Store and manage Attendance data securly stored in digital account',
      'assets/ob/img_ob_att.png'
  ),
  new PageViewModel(
      const Color(0xFF65B0B4),
      'assets/ob/img_ob_att.png',
      'Build for Students and Teachers',
      'Directly Share Class Notes and materials, helping student share code and get guidance',
      //TODO : add more content
      'assets/ob/img_ob_att.png'
  ),
  new PageViewModel(
    const Color(0xFF9B90BC),
    'assets/ob/img_ob_att.png',
    'Easily Track attendance',
    'Detailed Analysis made and Statics report avaliable even save as xml offine',
    'assets/ob/img_ob_att.png',
  ),
];

class Page extends StatelessWidget {

  final PageViewModel viewModel;
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
                    padding: new EdgeInsets.only(bottom: 75.0),
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
              ]
          ),
        )
    );
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;

  PageViewModel(
      this.color,
      this.heroAssetPath,
      this.title,
      this.body,
      this.iconAssetPath,
      );
}
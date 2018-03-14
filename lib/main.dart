import 'dart:async';

import 'package:attendance_assistant/pages/attendance_screen.dart';
import 'package:attendance_assistant/pages/landing_page.dart';
import 'package:attendance_assistant/pages/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


//void main() {
//  runApp(new MaterialApp(
//    //TODO login Preference
////    home: prefs.getBool('LoadOB') != null ? new LandingPage() : new Onboarding(),
//
//
//  ));
//}
getCookie() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String cookie = prefs.getString('email') ?? '';
  debugPrint(cookie.toString());
  if (cookie == ''){
    runApp(new Onboarding());
  } else {
    runApp(new AttendanceScreen());
  }
}

void main() {
  getCookie();
}
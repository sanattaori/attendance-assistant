import 'dart:async';

import 'package:attendance_assistant/pages/attendance_screen.dart';
import 'package:attendance_assistant/pages/landing_page.dart';
import 'package:attendance_assistant/pages/live_help.dart';
import 'package:attendance_assistant/pages/onboarding.dart';
import 'package:firebase_database/firebase_database.dart';
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
    runApp(new MaterialApp(home: new Onboarding(),));
  } else {
    runApp(new MaterialApp(home: new AttendanceScreen(),));
  }
}

void main() {
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  reference.keepSynced(true);
  getCookie();
}
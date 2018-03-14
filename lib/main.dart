import 'dart:async';

import 'package:attendance_assistant/pages/attendance_screen.dart';
import 'package:attendance_assistant/pages/landing_page.dart';
import 'package:attendance_assistant/pages/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  var email = runthis();
  runApp(new MaterialApp(
    //TODO login Preference
//    home: prefs.getBool('LoadOB') != null ? new LandingPage() : new Onboarding(),
  home: email != null ? new Onboarding() : new AttendanceScreen(),
  ));
}

Future runthis() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = prefs.getString('email').toString();
  debugPrint(email);
  return email;
}
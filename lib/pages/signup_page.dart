import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

String error = "";

class PersonData {
  String name = '';
  String phoneNumber = '';
  String email = '';
  String password = '';
}

class SignupPage extends StatefulWidget {

  int value;
  SignupPage({ Key key }) : super(key: key);

  @override
  SignupPageState createState() => new SignupPageState();
}

class SignupPageState extends State<SignupPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  PersonData email_pass = new PersonData();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  //keys
  bool _autovalidate = false;
  bool _formWasEdited = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = new GlobalKey<
      FormFieldState<String>>();

  //show Snackbar
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  void _handleSignup() async {
    final FormState form = _formKey.currentState;
    //validate form
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      showInSnackBar('Signing Up...');
    }
  }

    String _validateName(String value) {
      _formWasEdited = true;
      if (value.isEmpty)
        return 'Name is required.';
      final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
      if (!nameExp.hasMatch(value))
        return 'Please enter only alphabetical characters.';
      return null;
    }

    String _validatePassword(String value) {
      _formWasEdited = true;
      final FormFieldState<String> passwordField = _passwordFieldKey
          .currentState;
      if (passwordField.value == null || passwordField.value.isEmpty)
        return 'Please choose a password.';
      if (passwordField.value != value)
        return 'Passwords don\'t match';
      return null;
    }


    @override
    Widget build(BuildContext context) {
     return new Scaffold(
       key: _scaffoldKey,
       appBar: new AppBar(
         title: const Text("Register"),

       ),

     );
    }

}
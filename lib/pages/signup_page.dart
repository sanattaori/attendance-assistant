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

  //hero




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
        return 'Email is required.';
      String r = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      final RegExp emailExp = new RegExp(r);
      if (!emailExp.hasMatch(value))
        return 'Please enter Valid Email';
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

      // hero center
      var decoratedBox = new DecoratedBox(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              fit: BoxFit.fitWidth,
              image: new AssetImage('assets/logos/professor.jpg'),
            ),
            shape: BoxShape.circle,
          )
      );
      var hero = new Hero(
        tag: 'hero-tag-llama',
        child: decoratedBox,
      );

      var center = new Center(
        child: new Container(
          height: 100.0,
          width: 100.0,
          child: hero,
        ),);




     return new Scaffold(
       key: _scaffoldKey,
       appBar: new AppBar(
         title: const Text("Register"),
       ),
       backgroundColor: Colors.white70,
       body: new SafeArea(
           top: false,
           bottom: false,
           child: new Form(
             key: _formKey,
             autovalidate: _autovalidate,
             child: new ListView(
               padding: new EdgeInsets.all(20.0),
               children: <Widget>[
                 center,
                 new TextFormField(
                    decoration: new InputDecoration(
                      icon: new Icon(Icons.person),
                      hintText: 'Enter Email',
                      labelText: 'Email',

                    ),
                   keyboardType: TextInputType.emailAddress,
                   onSaved: (String value) {email_pass.email = value;},
                   validator: _validateName,
                 ),
                 //new Padding(padding: new EdgeInsets.symmetric(vertical: 20.0)),
                 new TextFormField(
                   key: _passwordFieldKey,
                   decoration: new InputDecoration(
                     icon: new Icon(Icons.lock),
                     hintText: 'Enter password',
                     labelText: 'Password',
                   ),
                   obscureText: true,
                   onSaved: (String value) {
                     email_pass.password = value;
                   },

                 ),
                 new TextFormField(
                   decoration: new InputDecoration(
                     icon: new Icon(null),
                     hintText: 'How do you log in?',
                     labelText: 'Re-type Password *',
                   ),
                   obscureText: true,
                   onFieldSubmitted: (String value) { _handleSubmitted(); },
                   validator: _validatePassword,
                 ),
                 new Container(
                   padding: const EdgeInsets.all(20.0),
                   alignment: Alignment.center,
                   child: new RaisedButton(
                     child: const Text('SUBMIT'),
                     onPressed: _handleSubmitted,
                   ),
                 ),



               ],
             ),
           )
       ),
     );
    }


  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      showInSnackBar('${email_pass.email}\'s phone number is ${email_pass.password}');
    }
  }
}
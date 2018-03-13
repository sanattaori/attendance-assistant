import 'package:attendance_assistant/pages/attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/scheduler.dart';

String error = "";

class PersonData {
  String email = '';
  String password = '';
}

//final String value="";

class SignupPage extends StatefulWidget {
  final String value;

  //final int value;

  //SignupPage({ this.value, Key key }) : super(key: key);
  const SignupPage({
    Key key,
    this.value ,
  }) :super(key: key);



  //final String value;

  @override
  SignupPageState createState() => new SignupPageState(value);
}

class SignupPageState extends State<SignupPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //final int value = new SignupPage().value;
  PersonData email_pass = new PersonData();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool _autovalidate = false;
  bool _formWasEdited = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = new GlobalKey<
      FormFieldState<String>>();

  String value;

  SignupPageState(this.value);



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
        return 'Please choose a password';
      if (passwordField.value.length < 8)
        return 'Enter minimum 8 characters';
      if (passwordField.value != value)
        return 'Passwords don\'t match';
      return null;
    }

    @override
    Widget build(BuildContext context) {
      timeDilation = 2.0;
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
        tag: 'hero-tag-llama2',
        child: decoratedBox,
      );

      var center = new Center(
        child: new Container(
          height: 100.0,
          width: 100.0,
          child: hero,
        ),);

      // hero center
      var decoratedBox2 = new DecoratedBox(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              fit: BoxFit.fitWidth,
              image: new AssetImage('assets/logos/stu.jpg'),
            ),
            shape: BoxShape.circle,
          )
      );
      var hero2 = new Hero(
        tag: 'hero-tag-llama',
        child: decoratedBox2,
      );

      var center2 = new Center(
        child: new Container(
          height: 100.0,
          width: 100.0,
          child: hero2,
        ),);


     return new Scaffold(
       key: _scaffoldKey,
       appBar: new AppBar(
         title: const Text("Register"),
       ),
       backgroundColor: value == "1" ? Colors.orangeAccent : Colors.yellow ,
       body: new SafeArea(
           top: false,
           bottom: false,
           child: new Form(
             key: _formKey,
             autovalidate: _autovalidate,
             child: new ListView(
               padding: new EdgeInsets.all(20.0),
               children: <Widget>[
                 value == "1" ? center:center2,
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
                     hintText: 'Enter password again',
                     labelText: 'Re-type Password',
                   ),
                   obscureText: true,
                   onFieldSubmitted: (String value) { _handleSubmitted(); },
                   validator: _validatePassword,
                 ),
                 new Padding(padding: new EdgeInsets.only(bottom: 20.0)),
                 new Container(
                   //padding: const EdgeInsets.all(20.0),
                   alignment: Alignment.center,
                   child: new RaisedButton(
                     child: const Text('Register/Login'),
                     onPressed: _handleSubmitted,
                     splashColor: value == "1" ? Colors.orangeAccent : Colors.yellow,
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
      //showInSnackBar('${email_pass.email}\'s password is ${email_pass.password}');

      _signup()
          // ignore: strong_mode_uses_dynamic_as_bottom
          .then((FirebaseUser user) {
            //print(user);
            //showInSnackBar(user.toString());
            //Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => new LandingPage()));

          })
          .catchError((e) {
            showInSnackBar(e.message);

          });
    }
  }

  Future _signup() async {
    try {
      FirebaseUser auth = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email_pass.email, password: email_pass.password);
      showInSnackBar("Signup successful!");
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => new AttendanceScreen(auth)));

    } catch (e) {
      debugPrint(e.toString());
      if(e.message=='The email address is already in use by another account.') {
          //_login();
        _login().catchError((e) {
          showInSnackBar(e.message);
        });
      }
    }
    //
//    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//    await firebaseAuth
//        .createUserWithEmailAndPassword(
//        email: email_pass.email, password: email_pass.password);
//    showInSnackBar("Signup Successful!");
  }

  Future _login() async {
    FirebaseUser user = await FirebaseAuth
        .instance.signInWithEmailAndPassword(email: email_pass.email,
        password: email_pass.password);
    debugPrint(user.toString());
    showInSnackBar("Login successful!");
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => new AttendanceScreen(user)));
    //showInSnackBar(user.toString());
    debugPrint(email_pass.password.toString());
  }
}
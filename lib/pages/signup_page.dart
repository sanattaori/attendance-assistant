import 'package:attendance_assistant/pages/attendance_screen.dart';
import 'package:attendance_assistant/pages/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

String error = "";

class PersonData {
  String name = '';
  String email = '';
  String password = '';
}

//final String value="";

class SignupPage extends StatefulWidget {
  final int value;

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

  int value;

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

    String _validateEmail(String value) {
      _formWasEdited = true;
      if (value.isEmpty)
        return 'Email is required.';
      String r = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      final RegExp emailExp = new RegExp(r);
      if (!emailExp.hasMatch(value))
        return 'Please enter Valid Email';
      return null;
    }

    String _validateName(String value) {
      _formWasEdited = true;
      if (value.isEmpty)
        return 'Name is required.';
      String r = "([a-zA-Z]{3,30}\s*)+";
      final RegExp emailExp = new RegExp(r);
      if (!emailExp.hasMatch(value))
        return 'Please enter Valid Name';
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
       backgroundColor: value == 1 ? Colors.deepOrangeAccent : Colors.yellow ,
       body: new SafeArea(
           top: false,
           bottom: false,
           child: new Form(
             key: _formKey,
             autovalidate: _autovalidate,
             child: new ListView(
               padding: new EdgeInsets.all(20.0),
               children: <Widget>[
                 //icon
                 value == 1 ? center:center2,
                 new TextFormField(
                   decoration: new InputDecoration(
                     icon: new Icon(Icons.supervised_user_circle),
                     hintText: 'Enter Name',
                     labelText: 'Name',
                   ),
                   keyboardType: TextInputType.text,
                   onSaved: (String value) {email_pass.name = value;},
                   validator: _validateName,
                 ),
                 new TextFormField(
                    decoration: new InputDecoration(
                      icon: new Icon(Icons.person),
                      hintText: 'Enter Email',
                      labelText: 'Email',
                    ),
                   keyboardType: TextInputType.emailAddress,
                   onSaved: (String value) {email_pass.email = value;},
                   validator: _validateEmail,
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
                 new Row(
                   children: <Widget>[
                     new Container(
                       alignment: Alignment.center,
                         child: new RaisedButton(
                           child: const Text('Register'),
                           onPressed: _handleSubmitted,
                           splashColor: value == 1 ? Colors.deepOrangeAccent : Colors.yellow,
                         ),
                       ),
                      new Padding(padding: new EdgeInsets.only(left: 100.0)),
                      new Container(
                      alignment: Alignment.center,
                      child: new RaisedButton(
                      child: const Text('Login'),
                      onPressed: _handleLogin,
                      splashColor: value == 1 ? Colors.deepOrangeAccent : Colors.yellow,
                    ),
                  ),
                ],
             ),
            ],
           ),
       ),
       )
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
            //showInSnackBar(e.message);

          });
    }
  }

  Future _signup() async {
    try {
      FirebaseUser auth = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email_pass.email, password: email_pass.password);
      showInSnackBar("Signup successful!");
      loadOnce(auth);
      //# TODO Set auth and user values along with token to preferences.
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => new BarcodeScan()));

    } catch (e) {
      debugPrint(e.toString());
      showInSnackBar(e.message);
      if(e.message=='The email address is already in use by another account.') {
        showInSnackBar('Try to signup with different account');
          //_login();
//        _login().catchError((e) {
//          showInSnackBar(e.message);
//        });
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
    try {
      FirebaseUser user = await FirebaseAuth
          .instance.signInWithEmailAndPassword(email: email_pass.email,
          password: email_pass.password);


      debugPrint(user.toString());
      showInSnackBar("Login successful!");
      loadOnce(user);
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => new BarcodeScan()));

    } catch (e) {
      showInSnackBar(e.message);
    }
    //showInSnackBar(user.toString());
    //debugPrint(email_pass.password.toString());
  }

  void _handleLogin() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      _login().catchError((e) {
        //showInSnackBar(e.message);
      });
    }
  }

  Future loadOnce(user) async {
    debugPrint(user.toString()+ "token:");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Auth', true);
    prefs.setString('email', user.email.toString());
    prefs.setString('User', user.uid.toString());
    prefs.setInt('Role', value);
    prefs.setString('Name',email_pass.name);
//    prefs.setString('token', user.token.toString());
//    debugPrint('run success');
  }
}
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SigninPage extends StatefulWidget {
  @override
  SigninPageState createState() => new SigninPageState();
}

class SigninPageState extends State<SigninPage> {

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignin() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
      print("Returned user object: " + user.toString());
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Sign in"),),
      body: new Container(
        padding: new EdgeInsets.all(50.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField( // email input
              controller: _emailController,
              decoration: new InputDecoration(
                  hintText: "Email"
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            new TextField( // password input
              controller: _passwordController,
              decoration: new InputDecoration(
                hintText: "Password",
              ),
              obscureText: true,
            ),
            new Padding(padding: new EdgeInsets.only(bottom: 50.0)),
            new RaisedButton(
              onPressed: () => _handleSignin(),
              child: new Text("Sign in"),
            )
          ],
        ),
      ),
    );
  }
}
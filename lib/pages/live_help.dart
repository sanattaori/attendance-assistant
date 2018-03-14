import 'package:flutter/material.dart';

class LiveHelp extends StatefulWidget {
  LiveHelpState createState()=> new LiveHelpState();
}

class LiveHelpState extends State<LiveHelp>{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
      appBar: new AppBar(title: new Text("Get Live Help")),
      body: new Text("test"),
      ),
    );
  }
}

import 'dart:async';
import 'package:attendance_assistant/pages/landing_page.dart';
import 'package:attendance_assistant/pages/live_help.dart';
import 'package:attendance_assistant/pages/qr_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qrcode_reader/QRCodeReader.dart';
import 'package:firebase_database/firebase_database.dart';




class BarcodeScan extends StatefulWidget {
  BarcodeScan({Key key}) : super(key: key);
  @override
  BarcodeScanState createState() => new BarcodeScanState();
}

class BarcodeScanState extends State<BarcodeScan> with TickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
  }


  List<String> list = [];
  int i = 1;
  // ignore: non_constant_identifier_names
  String result_names = '';
  String names = '';
  Future<String> _barcodeString;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final reference = FirebaseDatabase.instance.reference().child('users/' + getUserId().toString());

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text("Attendance Assistant"),
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.help),
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new LiveHelp()));
                  }
              ),
            ],
          ),
          body: new Stack(
            children: <Widget>[
              new FutureBuilder<SharedPreferences>(
                  future: _prefs,
                  builder: (BuildContext context,
                      AsyncSnapshot<SharedPreferences> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return const Text('Loading...');
                    final int role = snapshot.requireData.getInt('Role') ?? '';
                    final String name = snapshot.requireData.getString('Name') ?? '';
                    if(role == 1) {
                      return new Center(
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              child: new MaterialButton(
                                  onPressed: (){
                                    setState(() {
                                      _barcodeString = new QRCodeReader()
                                          .setAutoFocusIntervalInMs(200) // default 5000
                                          .setForceAutoFocus(true) // default false
                                          .setTorchEnabled(true) // default false
                                          .setHandlePermissions(true) // default true
                                          .setExecuteAfterPermissionGranted(true) // default true
                                          .scan();
                                    });
                                  }, child: new Text("Take Attendance")),
                              padding: const EdgeInsets.all(8.0),
                            ),
                            new FutureBuilder<String>(
                                future: _barcodeString,
                                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

                                  if(snapshot.data!= null){
                                    if(names == snapshot.data.toString()) {
                                      //showInSnackBar("Attendance already marked");
                                    } else {
                                      result_names += (i++).toString() + '. ' + snapshot.data.toString() + '\n';
                                      list.add(snapshot.data.toString());
                                      debugPrint('from not null' + list.toString());
                                      debugPrint('from not null' + result_names.toString());
                                      names = snapshot.data.toString();
                                    }
                                  }


                                  debugPrint(result_names.toString());
                                  return new Text(snapshot.data != null ? 'Marked attendance: \n' + result_names : '',style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,),);
                                }),
                          ],
                        ),
                      );
                      //scan qr
                    }
                    if(role == 2) {
                      return new QrImage(
                        data: name,
                        size: 200.0,
                      );
                      //generate qr student (2)
                    }
                  }
              ),
            ],
          ),
          drawer: new Drawer(
            child: new Column(
              children: <Widget>[

                new UserAccountsDrawerHeader(
                  accountName:
                  new FutureBuilder<SharedPreferences>(
                      future: _prefs,
                      builder: (BuildContext context,
                          AsyncSnapshot<SharedPreferences> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return const Text('Loading...');
                        final String name = snapshot.requireData.getString('Name') ?? '';
                        return new Text(name);
                      }
                  ),
                  accountEmail:
                  new FutureBuilder<SharedPreferences>(
                      future: _prefs,
                      builder: (BuildContext context,
                          AsyncSnapshot<SharedPreferences> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return const Text('Loading...');
                        final String email = snapshot.requireData.getString('email') ?? '';
                        return new Text(email);
                      }
                  ),
                ),
                new MaterialButton(onPressed: (){
                  logOut();
                }, child: new Text('Logout',textAlign: TextAlign.left,)),
              ],
            ),
          ),
        )
    );
  }

  Future logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', null);
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => new LandingPage()));
    //debugPrint(cookie.toString());
  }


//  Future scan() async {
//    try {
//      String barcode = await BarcodeScanner.scan();
//      setState(() => this.barcode = barcode);
//    } on PlatformException catch (e) {
//      if (e.code == BarcodeScanner.CameraAccessDenied) {
//        setState(() {
//          this.barcode = 'The user did not grant the camera permission!';
//        });
//      } else {
//        setState(() => this.barcode = 'Unknown error: $e');
//      }
//    } on FormatException{
//      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
//    } catch (e) {
//      setState(() => this.barcode = 'Unknown error: $e');
//    }
//  }


}

Future<String> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString('User');
  return uid;
}

class NameEntries {
  String key;
  DateTime dateTime;

  String names;

  NameEntries(this.dateTime, this.names);

  NameEntries.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        dateTime =
        new DateTime.fromMillisecondsSinceEpoch(snapshot.value["date"]),
        names = snapshot.value["names"];

  toJson() {
    return {
      "date": dateTime.millisecondsSinceEpoch,
      "names": names
    };
  }
}
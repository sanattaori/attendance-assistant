import 'dart:async';
import 'package:attendance_assistant/pages/landing_page.dart';
import 'package:attendance_assistant/pages/live_help.dart';
import 'package:attendance_assistant/pages/qr_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qrcode_reader/QRCodeReader.dart';

class BarcodeScan extends StatefulWidget {
  @override
  BarcodeScanState createState() => new BarcodeScanState();
}

class BarcodeScanState extends State<BarcodeScan> with TickerProviderStateMixin{

  Future<String> _barcodeString;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text("QR Scan"),
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
                                  return new Text(snapshot.data != null ? snapshot.data : '');
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
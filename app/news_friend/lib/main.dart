import 'package:flutter/material.dart';
import 'dart:async';
import 'apiCall.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription _intentDataStreamSubscription;
  List<SharedMediaFile> _sharedFiles;
  String _sharedText = "noText";


  @override
  void initState() {
    super.initState();

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        _sharedText = value;
        print("Shared: $_sharedText");
      });
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String value) {
      setState(() {
        _sharedText = value;
        print("Shared: $_sharedText");
      });
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textStyleBold = const TextStyle(fontWeight: FontWeight.bold);

    if (_sharedText == "noText"){
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
          title: const Text('News Friend'),
          ),
        body: Center(
          child: Column(children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter URL'
              ),
              onChanged: (text) {
                _sharedText = text;
              }
            ),
            RaisedButton(
              child: Text("Submit"),
            )
          ],),
          )
        ),
      );
    }
  }
  // else{
  //   navigator.push()...
  // }
}
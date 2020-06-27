import 'package:flutter/material.dart';
import 'dart:async';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'Loading.dart';
import 'urlProcessing.dart';
import 'package:page_transition/page_transition.dart';




class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  StreamSubscription _intentDataStreamSubscription;
  List<SharedMediaFile> _sharedFiles;
  String sharedText = "noText";

  void urlCallback(String processedUrl, String original){
    setState(() {
      sharedText = processedUrl;
    });
    if (processedUrl != "Invalid URL"){
      // Navigator.push(context,MaterialPageRoute(builder: (context) => Loading(processedUrl, original)));
      Navigator.push(context, PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 500), child: Loading(processedUrl, original)));

      // Navigator.of(context).push(PageRouteTransition(
      //   animationType: AnimationType.fade,
      //   curves: Curves.easeInOut,
      //   builder: (context) => Loading(processedUrl, original))); 
    }
    else{
      ShowDialog(context, original);
    }
  }

  @override
  void initState() {
    super.initState();
    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      if (value != null && value != 'null'){
        processUrl(value, callback: urlCallback);
      }
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String value) {
      if (value != null && value != 'null'){
        processUrl(value, callback: urlCallback);
      }
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    sharedText = "noText";
    return Scaffold(
        appBar: AppBar(
        title: const Text('News Friend'),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Image(image: AssetImage('assets/cover.png')),
              ),
            Text("make sure to include https:// or http:// before your url. Eg \"https://google.com\" "),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: sharedText
              ),
              onChanged: (text) {
                sharedText = text;
              }
            ),
            RaisedButton(
              child: Text("Submit"),
              onPressed: (){
                processUrl(sharedText, callback: urlCallback);
              },
            ),
            Expanded(flex : 2, child: Container())
        ],),
        )
      );
  }
}
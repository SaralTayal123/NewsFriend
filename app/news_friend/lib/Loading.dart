import 'package:flutter/material.dart';
import 'package:newsfriend/Results.dart';
import 'dart:async';
import 'apiCall.dart';
import 'Results.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

class Loading extends StatefulWidget {
  final String url;
  final String originalUrl;
  const Loading(this.url, this.originalUrl);
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading>{

  String newsProvider(String str){
    String start = "www.";
    String end = ".";
    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end, (startIndex + start.length + 1));

    return (str.substring(startIndex + start.length, endIndex)); 
  }

  void apiCall() async{
    var api = ApiCall();
    NewsData newsData = await api.getData(widget.url);
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Results(newsData)));
    Navigator.push(context, PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 500), child: Results(newsData)));

    // Navigator.of(context).push(PageRouteTransition(
    //     animationType: AnimationType.fade,
    //     curves: Curves.easeInOut,
    //     builder: (context) => Results(newsData))); 
  }

  @override
  void initState() {
    //url call here
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title: const Text('News Friend'),
        ),
      body: Center(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Image(image: AssetImage('assets/cover.png')),
              ),
            SpinKitFoldingCube(
              color: Colors.blue,
              size: 200.0,
              // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
              ),
            Text(newsProvider(widget.originalUrl)),
            Text((widget.originalUrl)),
        ],),)
        
        
        )
      ),
    );
    }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       appBar: AppBar(
  //       title: const Text('News Friend'),
  //       ),
  //     body: Center(
  //       child: Text(widget.url)
  //       )
  //     ),
  //   );
  //   }
}

import 'package:flutter/material.dart';
import 'package:newsfriend/Results.dart';
import 'dart:async';
import 'apiCall.dart';
import 'Results.dart';


class Loading extends StatefulWidget {
  final String url;
  const Loading(this.url);
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading>{


  void apiCall() async{
    var api = ApiCall();
    NewsData newsData = await api.getData(widget.url);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Results(newsData)));
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
        child: Text(widget.url)
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

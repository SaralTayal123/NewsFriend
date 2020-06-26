import 'package:flutter/material.dart';



class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading>{

  @override
  void initState() {
    //url call here
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
        child: Text("Loading")
        )
      ),
    );
    }
}

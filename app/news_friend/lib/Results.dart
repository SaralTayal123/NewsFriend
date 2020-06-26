import 'package:flutter/material.dart';
import 'dart:async';
import 'apiCall.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';



class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results>{
  static double animationTest = 10;

  @override
  Widget build(BuildContext context) {
    const textStyleBold = const TextStyle(fontWeight: FontWeight.bold);
    return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('News Friend'),
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  // Image(image: ,) Logo image
                  // Text(_sharedText ?? ""), 
                  Text(" Headlines goes here "),
                  Text(" Website goes here "),
                  Text(" Category goes here "),
                  Text(" Sentiment go here "),
                  Row(children: <Widget>[
                    SleekCircularSlider(
                    appearance: CircularSliderAppearance(),
                    min: 10,
                    max: 28,
                    initialValue: animationTest,
                    ),
                    SleekCircularSlider(
                      appearance: CircularSliderAppearance(),
                      min: 10,
                      max: 28,
                      initialValue: animationTest,
                    )
                  ],),
                  Text(" Related Stories go here "),
                  Text(" Website goes here "),
                  
                ],
              ),
            ),
          ),
        );
  }

}



  


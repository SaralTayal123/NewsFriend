import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'apiCall.dart';



class Results extends StatefulWidget {
  NewsData newsData;
  Results(this.newsData);
  @override
  _ResultsState createState() => _ResultsState();
}


class _ResultsState extends State<Results>{
  static double animationTest = 10;
  static List<Widget> resultWidgets = [];

  @override
  void initState() {
    resultWidgets = [
      Hero(
        tag: 'logo',
        child: Image(image: AssetImage('assets/cover.png')),
        ),
      Image.network(widget.newsData.image),
      Text(widget.newsData.headline),
      Text(widget.newsData.provider),
      Text(" Category goes here "),
      Text(widget.newsData.sentiment.toStringAsFixed(3)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SleekCircularSlider(
          appearance: CircularSliderAppearance(),
          min: 0,
          max: 100,
          initialValue: widget.newsData.readability,
          ),
          SleekCircularSlider(
            appearance: CircularSliderAppearance(),
            min: 0,
            max: 15,
            initialValue: widget.newsData.readingTime,
          )
      ],),
      SleekCircularSlider(
          appearance: CircularSliderAppearance(),
          min: 0,
          max: 100,
          initialValue: (widget.newsData.rating * 100),
        ),
      Text(" Related Stories go here "),
      Text(" Website goes here "),
    ];

    widget.newsData.relatedNews.forEach((element) {
      print("news item \n");
      print (element);
      resultWidgets.add(newsWidgetGenerator(element));
     });

    super.initState();
  }

  Widget newsWidgetGenerator(element){
    return Container(
      child: Row(children: <Widget>[
        Expanded(
          child: Image.network(element['image']),// add image,
          flex: 2
          ),
        Expanded(
          flex: 3,
          child: Column(children: <Widget>[
            Text(element['headline']),
            Text(element['newsProvider']),
            Text(element['readability'].toString()),
            Text(element['readingTime'].toString()),
            Text(element['sentiment'].toString()),
          ],)
          )
        
      ],),
      );

  }



  @override
  Widget build(BuildContext context) {
    const textStyleBold = const TextStyle(fontWeight: FontWeight.bold);
    return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('News Friend'),
            ),
            body: ListView(
              padding: const EdgeInsets.all(8),
              children: resultWidgets
            )
            
          ),
        );
  }

}



  


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
      Text("Placeholder"),
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
            Text(element['rating'].toString()),
          ],)
          )
        
      ],),
      );

  }



  @override
  Widget build(BuildContext context) {
    Size preferredSize = Size.fromHeight(MediaQuery.of(context).size.height/3.5);
    resultWidgets[0] = Hero(
          tag: "head",
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
            SizedBox.fromSize(
            size: preferredSize,
            child: new LayoutBuilder(builder: (context, constraint) {
              final width = constraint.maxWidth * 8;
              return new ClipRect(
                child: new OverflowBox(
                  maxHeight: double.infinity,
                  maxWidth: double.infinity,
                  child: new SizedBox(
                    width: width,
                    height: width,
                    child: new Padding(
                      padding: new EdgeInsets.only(
                        bottom: (width / 2 - preferredSize.height / 2) + 20),                    
                      child: new DecoratedBox(
                        position: DecorationPosition.background,
                        decoration: new BoxDecoration(
                          color: Color(0xfffdedee),
                          shape: BoxShape.circle,
                          boxShadow: [
                            new BoxShadow(color: Colors.black54, offset: Offset.fromDirection(180, 10), blurRadius: 20.0, spreadRadius: 1)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
            Center(
              // child: Hero(
              //   tag: 'logo',
                child: Image(image: AssetImage('assets/cover.png')),
                // ),
            ),
          ],
          // padding: EdgeInsets.only(bottom: 10),
        ),
      );
    const textStyleBold = const TextStyle(fontWeight: FontWeight.bold);
    return MaterialApp(
          home: Scaffold(
            body: ListView(
              children: resultWidgets
            )
            
          ),
        );
  }

}



  


import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'apiCall.dart';
import 'package:google_fonts/google_fonts.dart';




class Results extends StatefulWidget {
  NewsData newsData;
  Results(this.newsData);
  @override
  _ResultsState createState() => _ResultsState();
}
  BoxDecoration cardDecoration(Color mainC, Color background, double rad){
    BoxDecoration cardDecoration = BoxDecoration(
      color: mainC,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(rad),
          topRight: Radius.circular(rad),
          bottomLeft: Radius.circular(rad),
          bottomRight: Radius.circular(rad)
      ),
      boxShadow: [
        BoxShadow(
          color: background.withOpacity(0.3),
          spreadRadius: 1.5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );
    return cardDecoration;
  }

class _ResultsState extends State<Results>{
  static double animationTest = 10;
  static List<Widget> resultWidgets = [];

  @override
  void initState() {
    resultWidgets = [
      Text("Placeholder"),
      Column(
        crossAxisAlignment:  CrossAxisAlignment.center,
        children: <Widget>[
        Container(
          decoration: cardDecoration(Colors.white, Colors.grey, 15),
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          alignment: Alignment.center,
          child: Text("Headline: " + widget.newsData.headline + "- " + widget.newsData.provider,
          textAlign: TextAlign.center,
          style: GoogleFonts.zillaSlab(
                        color: Color(0xff003045),
                        fontSize: 25.0,
                        fontWeight: FontWeight.w400,
                      )
            ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: cardDecoration(Colors.white, Colors.grey, 15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(widget.newsData.image),
          ),
        ),
        
        
        Container(
          decoration: cardDecoration(Colors.green, Colors.green, 15),
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          alignment: Alignment.center,
          // color: Colors.blue,
          child: Text(" Category goes here ",
            style: GoogleFonts.zillaSlab(
                        color: Color(0xff003045),
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      )
          ),
        ),
        Container(
          decoration : cardDecoration(Colors.orange, Colors.orange, 15),
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          alignment: Alignment.center,
          child: Text("Sentiment: " + widget.newsData.sentimentString,
            style: GoogleFonts.zillaSlab(
                        color: Color(0xff003045),
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      )
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              decoration: cardDecoration(Colors.white, Colors.grey, 15),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              // color: Colors.blue,
              child:  SleekCircularSlider(
                appearance: CircularSliderAppearance(),
                min: 0,
                max: 100,
                initialValue: widget.newsData.readability,
                ),
            ),
            Container(
              decoration: cardDecoration(Colors.white, Colors.grey, 15),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              // color: Colors.blue,
              child: SleekCircularSlider(
                appearance: CircularSliderAppearance(),
                min: 0,
                max: 15,
                initialValue: widget.newsData.readingTime,
              )
            ),
            
        ],),
        Row(children: <Widget>[
          Expanded(flex: 1, child: Container(),),
          Container(
                decoration: cardDecoration(Colors.white, Colors.grey, 15),
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                alignment: Alignment.center,
                // color: Colors.blue,
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(),
                  min: 0,
                  max: 100,
                  initialValue: (widget.newsData.rating * 100),
                ),
              ),
          Expanded(flex: 1, child: Container(),),
        ],),
      ],)
      
    ];

    List<Widget> widgetList = [];
    widgetList.add(Container(
      child: textFormatted("Related News:", 30, FontWeight.w500 ),
      ));

    widget.newsData.relatedNews.forEach((element) {
      print("news item \n");
      print (element);
      widgetList.add(newsWidgetGenerator(element));
     });

    Widget relatedNewsContainer = Container(
      decoration:  BoxDecoration(
        color: Color(0xfffefffa),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0)
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xfffefffa).withOpacity(0.3),
            spreadRadius: 1.5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: widgetList
      )
    );
    resultWidgets.add(relatedNewsContainer);
    super.initState();
  }

  Widget newsWidgetGenerator(element){
    return Container(
      decoration: cardDecoration(Color(0xfffaf7fa), Color(0xfffaf7fa), 15),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: Row(children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: cardDecoration(Colors.white, Colors.grey, 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(element['image']),
            ),
          )
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
              textFormatted("Headline: " + element['headline'], 15, FontWeight.w500),
              textFormatted("Provider: " + element['newsProvider'], 15, FontWeight.w400),
              textFormatted("Readability: " + element['readability'].toString(), 10, FontWeight.w400),
              textFormatted("Reading Time: " + element['readingTime'].toString(), 10, FontWeight.w400),
              textFormatted("Sentiment: " + element['sentiment'].toString(), 10, FontWeight.w400),
              textFormatted("rating: " + element['rating'].toString(), 10, FontWeight.w500),
            ],),
          )
          )
        
      ],),
      );

  }

  Widget textFormatted(String str, double size, FontWeight weight){
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      child: Text(str,
        style: GoogleFonts.zillaSlab(
          color: Color(0xff003045),
          fontSize: size,
          fontWeight: weight,
          )
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size preferredSize = Size.fromHeight(MediaQuery.of(context).size.height/5);
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
              child: Column(children: <Widget>[
                Image(image: AssetImage('assets/cover.png')),
                Text(widget.newsData.provider + ".com",
                  style: GoogleFonts.zillaSlab(
                              color: Color(0xff003045),
                              fontSize: 25.0,
                              fontWeight: FontWeight.w500,
                            )
                ),
              ],)
              // child: Hero(
              //   tag: 'logo',
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



  


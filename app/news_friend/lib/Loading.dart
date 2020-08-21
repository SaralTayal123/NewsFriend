import 'package:flutter/material.dart';
import 'package:newsfriend/Results.dart';
import 'dart:async';
import 'apiCall.dart';
import 'Results.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';

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
    String toRet =str.substring(startIndex + start.length, endIndex);
    toRet = toRet.toUpperCase();
    return toRet; 
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
    Size preferredSize = Size.fromHeight(MediaQuery.of(context).size.height/2.5);
    return MaterialApp(
      home: Scaffold(
      body: Center(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Hero(
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
            ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 80),
                child: SpinKitFoldingCube(
                  color: Color(0xff003045),
                  size: 150.0,
                  // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                  ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                child: Text(
                  newsProvider(widget.url),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.zillaSlab(
                    color: Color(0xff003045),
                    fontSize: 50.0,
                    fontWeight: FontWeight.w500,
                  )
                    )
                  ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                child: Text(
                  (widget.originalUrl),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.zillaSlab(
                    color: Color(0xff003045),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic
                    )
                  )
                ),
            ],),
          )
            
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

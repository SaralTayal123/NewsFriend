import 'package:flutter/material.dart';
import 'dart:async';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'Loading.dart';
import 'urlProcessing.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';




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

    Size preferredSize = Size.fromHeight(MediaQuery.of(context).size.height/2.5);
    sharedText = "noText";
    return Scaffold(
      backgroundColor: Colors.white,
        // appBar: AppBar(
        // title: const Text('News Friend'),
        // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
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
                                new BoxShadow(color: Color(0xff003045), offset: Offset.fromDirection(180, 10), blurRadius: 20.0, spreadRadius: 1)
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
                  child: Hero(
                    tag: 'logo',
                    child: Image(image: AssetImage('assets/cover.png')),
                    ),
                ),
              ],
              // padding: EdgeInsets.only(bottom: 10),
            ),
            // Text("make sure to include https:// or http:// before your url. Eg \"https://google.com\" "),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              margin:  EdgeInsets.symmetric(horizontal: 15, vertical: 50),
              decoration: ShapeDecoration(
                shape: StadiumBorder(),
                color: Color(0xfff0f1f4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 13),
                  Expanded(
                    child: TextFormField(
                      onChanged: (text) {
                        sharedText = text;
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Enter News URL Here",
                        hintStyle: TextStyle(
                          // fontFamily: GoogleFonts.zillaSlab(),
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      processUrl(sharedText, callback: urlCallback);
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.pink,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex : 2, child: Container(
              child: IconButton(
              icon: Icon(Icons.info, size: 40),
              onPressed: (){
                showDialog(
                context: context,
                builder: (BuildContext context) => aboutDialog(context),
              );
              }),
            ))
        ],),
        )
      );
  }
}

Widget aboutDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('How to use', textAlign: TextAlign.center,),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("This is a fairly simple app that allows you to pre-filter any news article before reading it. \n \nTo do so, simply paste a url above or share the article to the NewsFriend app from your browser. \n\nThe app will find the best alternative articles and rank your article based on readability/complexity of language, reading time/ article length, and the article's sentiment. After doing this for all the alternative articles, the algorithm will suggest rate your article and suggest the best alternative articles for you to read!")
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              textColor: Theme.of(context).primaryColor,
              child: const Text('Okay, got it!', textAlign: TextAlign.center,),
            )
          ]
        ),
      ],
    );
}


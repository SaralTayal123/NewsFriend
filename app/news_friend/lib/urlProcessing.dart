import 'package:flutter/material.dart';


bool urlChecker(String url){
  var urlPattern = r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
  var match = new RegExp(urlPattern, caseSensitive: false).firstMatch(url);
  match = RegExp(urlPattern, caseSensitive: false).firstMatch(url);
  print("match");
  print(match);
  if (match != null) return true;
  else return false;
}

String urlProcessor(String url){
  String result = url.replaceAll('/', '|');
  print("result");
  print(result);
  return result;
}

void processUrl(String url, {Function callback}){
  bool urlCheck = urlChecker(url);
  if (urlCheck == false){
    callback("Invalid URL", url);
    return;
  }
  else{
    callback(urlProcessor(url), url);
  }
}


void ShowDialog(context, url) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Invalid URL"),
          content: new Text("Invalid URL recieved: " + url + ". Please input a valid url that follows the sample format: \"https://google.com\" "),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
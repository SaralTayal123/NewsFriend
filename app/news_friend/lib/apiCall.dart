import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NewsData{
  String url;
  String headline;
  String text;
  double sentiment;
  double readability;
  double readingTime;
  double rating;
  List otherNews;

  NewsData({this.url, this.headline, this.text, this.sentiment, this.readability, this.readingTime, this. rating, this.otherNews});

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      url: json['url'],
      headline: json['headline'],
      text: json['text'],
      sentiment: json['sentiment'],
      readability: json['readability'],
      readingTime: json['readingTime'],
      rating: json['rating'],
      otherNews: json['otherNews'],
    );
  }
}

class ApiCall{
  Future <NewsData> getData(String url) async {

    //Clean URL
    // Merge with API url

    //************************************** */

    var response = await http.get("https://www.google.com"); // change to API url
    var temp = NewsData();
    return temp;
    //************************************** */
    // if (response.statusCode == 200) {
    //   return NewsData.fromJson(json.decode(response.body));
    // } 
    // else {
    //   throw Exception('Failed to get data');
    // }

  }

}


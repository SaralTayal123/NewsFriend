import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NewsData{
  String url;
  String image;
  String headline;
  String provider;
  double sentiment;
  double readability;
  double readingTime;
  double rating;
  List relatedNews;

  NewsData({this.url, this.headline, this.provider, this.sentiment, this.readability, this.readingTime, this. rating, this.relatedNews, this.image});

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      headline: json['headline'],
      sentiment: json['sentiment'],
      readability: json['readability'],
      readingTime: json['readingTime'],
      rating: json['rating'],
      relatedNews: json['relatedNews'],
      provider: json['newsProvider'],
      image: json['image']
    );
  }
}

class ApiCall{
  Future <NewsData> getData(String url) async {

    //Clean URL
    // Merge with API url

    //************************************** */
    print("getting information from: " + "https://newsfriend.herokuapp.com/ping/" + url);
    var response = await http.get("https://newsfriend.herokuapp.com/ping/" + url); // change to API url

    if (response.statusCode == 200) {
      return NewsData.fromJson(json.decode(response.body));
    } 
    else {
      throw Exception('Failed to get data');
    }

  }

}


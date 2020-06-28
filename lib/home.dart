import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rambo_news/model/news.dart';

Future<News> fetchTopNews() async {
  final response =
  await http.get('https://newsapi.org/v2/top-headlines?country=us&apiKey=b7f41b2702974fd09447e64cbed82dc0');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
//    return Album.fromJson(json.decode(response.body));

    News newss = News.fromJson(json.decode(response.body));

//    for(var n in newss.newsArticles){
//      print(n['title']);
//    }

    return newss;
//      Future res = json.decode(response.body);

//    print(res.);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load news');
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<News> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchTopNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RamboNews'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<News>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              for(var n in snapshot.data.newsArticles){
                return Text(n['description']);
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

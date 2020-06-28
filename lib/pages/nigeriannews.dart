import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rambo_news/main.dart';
import 'package:rambo_news/model/newsArticle.dart';
import 'package:rambo_news/pages/articleDetailsPage.dart';
import 'package:timeago/timeago.dart' as timeago;

const lightGreen = Color(0xff4CAF50);
const darkGreen = Color(0xff388E3C);
const yellowColor = Color(0xffFFEB3B);

Future fetchBitcoinUpdates() async {
  final response =
  await http.get('https://newsapi.org/v2/top-headlines?country=ng&apiKey=b7f41b2702974fd09447e64cbed82dc0');

  if (response.statusCode == 200) {

    print('got here');

    var tagObjsJson = jsonDecode(response.body)['articles'] as List;

    List<NewsArticle> NewsArticleList = tagObjsJson.map(
            (tagJson) => NewsArticle.fromJson(tagJson)
    ).toList();

    return NewsArticleList;

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load news');
  }
}

class NigerianNews extends StatefulWidget {
  @override
  _NigerianNewsState createState() => _NigerianNewsState();
}

class _NigerianNewsState extends State<NigerianNews> {

  Future newsArticless;

  @override
  void initState() {
    super.initState();
    newsArticless = fetchBitcoinUpdates();

  }

  String calculateTimeAgo(String date) {
    final now = new DateTime.now();
    final difference = now.difference(DateTime.parse(date));
    final fifteenAgo = now.subtract(difference);

    String readableDate = timeago.format(fifteenAgo);

    return readableDate;
  }

  Image ImageHere({String url}) {

//    url != null ? Image.network(url) : Image.asset('images/breakingnews.jpg');

  if (url != null) {
    return Image.network(url);
  }

  return Image.asset('images/breakingnews.jpg');

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nigerian News',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.none &&
                    snapshot.hasData == null) {
                  //print('project snapshot data is: ${projectSnap.data}');
                  return Container();
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    NewsArticle article = snapshot.data[index];
                    return InkWell(
                      onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleDetailsPage(url: article.url, title: article.title,)));
                    },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ImageHere(url: article.urlToImage),
                          SizedBox(height: 11,),
                          Text(
                            calculateTimeAgo(article.publishedAt) + ' by ' + article.sourceName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4,),
                          Text(
                            article.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
//                      SizedBox(height: 12,),
//                      Text(
//                        article.description,
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 16,
//                        ),
//                      ),
                          SizedBox(height: 24,),
//                        Divider(color: Colors.white, indent: 50, endIndent: 20,),
//                        SizedBox(height: 24,),
                          // Widget to display the list of project
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return Center(child: CircularProgressIndicator());


            },
            future: fetchBitcoinUpdates(),
          )
      ),
    );
  }
}

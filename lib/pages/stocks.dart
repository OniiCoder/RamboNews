import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesBloc.dart';
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesEvent.dart';
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesState.dart';
import 'package:rambo_news/main.dart';
import 'package:rambo_news/model/newsArticle.dart';
import 'package:rambo_news/pages/SavedArticlesPage.dart';
import 'package:rambo_news/pages/articleDetailsPage.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:badges/badges.dart';

const lightGreen = Color(0xff4CAF50);
const darkGreen = Color(0xff388E3C);
const yellowColor = Color(0xffFFEB3B);

Future fetchBitcoinUpdates() async {
  final response =
  await http.get('http://newsapi.org/v2/everything?q=stock&sortBy=publishedAt&apiKey=b7f41b2702974fd09447e64cbed82dc0');

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

class StockNews extends StatefulWidget {
  @override
  _StockNewsState createState() => _StockNewsState();
}

class _StockNewsState extends State<StockNews> {

  Future newsArticless;

  SavedArticlesBloc savedArticlesBloc;

  @override
  void initState() {
    savedArticlesBloc = BlocProvider.of<SavedArticlesBloc>(context);
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

  dynamic imageHere({String url}) {

    if (url != null) {
      return NetworkImage(url, scale: 1.0);
    }
    return AssetImage('images/breakingnews.jpg',);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Stock Market and News',
          style: TextStyle(
          fontSize: 24,
        ),),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SavedArticlesPage())),
            child: Row(
              children: [
                Text('Saved', style: TextStyle(color: Colors.white),),
                SizedBox(width: 3.0,),
                Badge(
                  badgeContent: BlocConsumer<SavedArticlesBloc, SavedArticlesState>(
                    cubit: savedArticlesBloc,
                    builder: (context, state) {
                      if(state is ArticlesFetched) {
                        return Text(state.articles.length.toString());
                      }
                      return Text(
                          ''
                      );
                    },
                    listener: (context, state){},
                  ),

                  child: Icon(Icons.favorite, color: Colors.white,),
                ),
              ],
            ),
          ),
        ],
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
                          Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(),
                                Container(
                                  height: 250,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                          image: imageHere(
                                            url: article.urlToImage,
                                          ),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                        child: BlocBuilder<SavedArticlesBloc, SavedArticlesState>(
                                          cubit: savedArticlesBloc,
                                          builder: (context, state) {
                                            print(state);

                                            if(state is NoArticlesSaved) {
                                              return FloatingActionButton(
                                                heroTag: index,
                                                onPressed: () => savedArticlesBloc.add(SavedArticlesEvent.saveArticle(article: article)),
                                                backgroundColor: Colors.green,
                                                child: Icon(Icons.favorite_border),
                                              );
                                            }

                                            if(state is ArticlesFetched) {
                                              bool exists = false;
                                              // loop to check if the article has already been saved
                                              for(var i=0; i<state.articles.length; i++) {
                                                // you may have to check the equality operator
                                                if(article.url == state.articles[i].url) {
                                                  exists=true;
                                                  break;
                                                }
                                              }

                                              if(exists){
                                                // saved already, do nothing
                                                return FloatingActionButton(
                                                  heroTag: index,
                                                  onPressed: () => savedArticlesBloc.add(SavedArticlesEvent.deleteOneArticle(article: article)),
                                                  backgroundColor: Colors.red,
                                                  child: Icon(Icons.restore_from_trash),
                                                );
                                              } else {
                                                return FloatingActionButton(
                                                  heroTag: index,
                                                  onPressed: () => savedArticlesBloc.add(SavedArticlesEvent.saveArticle(article: article)),
                                                  backgroundColor: Colors.green,
                                                  child: Icon(Icons.favorite_border),
                                                );
                                              }
                                            }

                                            return Container(
                                              height: 0.0,
                                              width: 0.0,
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 11,),
                          Text(
                            calculateTimeAgo(article.publishedAt) + ' by ' + article.sourceName,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4,),
                          Text(
                            article.title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 24,),
                          Divider(color: Colors.grey, indent: 50, endIndent: 20,),
                          SizedBox(height: 24,),
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

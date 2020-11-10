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
const blueColor = Color(0xff304FFF);
const greyColor = Color(0xffF8F8F8);

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

  Image ImageHere({String url}) {

  if (url != null) {
    return Image.network(url);
  }
  return Image.asset('images/breakingnews.jpg');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.library_books),
            SizedBox(width: 5,),
            Text(
              'Nigerian News',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        elevation: 0,
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
                    return Container(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: InkWell(
                        onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleDetailsPage(url: article.url, title: article.title,)));
                      },
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.all(22),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          article.title,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 30,),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                article.sourceName + ' | ' + calculateTimeAgo(article.publishedAt),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      height: 100,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: blueColor,
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                          image: article.urlToImage == null ? AssetImage('images/breakingnews.jpg') : NetworkImage(article.urlToImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            BlocBuilder<SavedArticlesBloc, SavedArticlesState>(
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
                          ],
                        ),

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

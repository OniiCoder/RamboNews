import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesBloc.dart';
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesEvent.dart';
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesState.dart';
import 'package:rambo_news/model/newsArticle.dart';
import 'package:http/http.dart' as http;
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

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  Future newsArticless;

  SavedArticlesBloc savedArticlesBloc;

  @override
  void initState() {
    savedArticlesBloc = context.read<SavedArticlesBloc>();

    newsArticless = fetchBitcoinUpdates();
    super.initState();

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
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Explore'),
        centerTitle: false,
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
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
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
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          NewsArticle article = snapshot.data[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleDetailsPage(url: article.url, title: article.title,)));
                            },
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width: 300,
                                  margin: EdgeInsets.only(top: 40, bottom: 20, right: 20, left: index == 0 ? 20 : 0),
                                  padding: EdgeInsets.symmetric(vertical: 22),
                                  decoration: BoxDecoration(
                                    // color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 300,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [

                                            CircularProgressIndicator(),
                                            Container(
                                              height: 300,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                image: DecorationImage(
                                                  image: article.urlToImage == null ? AssetImage('images/breakingnews.jpg') : NetworkImage(article.urlToImage),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 25,),
                                                  Text(
                                                    article.title,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white,
                                                        height: 1.3
                                                    ),
                                                  ),
                                                  SizedBox(height: 30,),
                                                  article.description != null ? Text(
                                                    article.description,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white.withOpacity(0.7),
                                                        height: 1.3
                                                    ),
                                                  ) : Container(),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    article.sourceName + ' | ' + calculateTimeAgo(article.publishedAt),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [

                                                        BlocBuilder<SavedArticlesBloc, SavedArticlesState>(
                                                          cubit: savedArticlesBloc,
                                                          builder: (context, state) {

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
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                // head count
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    index >= 10 ? '${index + 1}' : '0${index + 1}',
                                    style: TextStyle(
                                      // color: Colors.white,
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 3
                                        ..color = Colors.white,

                                    ),
                                  ),
                                )
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
            )
          ],
        ),
      ),
    );
  }
}

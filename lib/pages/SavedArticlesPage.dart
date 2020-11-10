import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesBloc.dart';
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesEvent.dart';
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesState.dart';
import 'package:rambo_news/main.dart';
import 'package:rambo_news/model/newsArticle.dart';
import 'package:rambo_news/pages/articleDetailsPage.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:badges/badges.dart';

const lightGreen = Color(0xff4CAF50);
const darkGreen = Color(0xff388E3C);
const yellowColor = Color(0xffFFEB3B);

class SavedArticlesPage extends StatefulWidget {
  @override
  _SavedArticlesPageState createState() => _SavedArticlesPageState();
}

class _SavedArticlesPageState extends State<SavedArticlesPage> {

  SavedArticlesBloc savedArticlesBloc;

  @override
  void initState() {
    savedArticlesBloc = BlocProvider.of<SavedArticlesBloc>(context);
    savedArticlesBloc.add(SavedArticlesEvent.fetchSavedArticles());
    super.initState();

  }

  String calculateTimeAgo(String date) {
    final now = new DateTime.now();
    final difference = now.difference(DateTime.parse(date));
    final fifteenAgo = now.subtract(difference);

    String readableDate = timeago.format(fifteenAgo);

    return readableDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Saved Articles',
          style: TextStyle(
            fontSize: 24,
          ),),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () => savedArticlesBloc.add(SavedArticlesEvent.clearArticles()),
            child: Row(
              children: [
                Text('Clear', style: TextStyle(color: Colors.white),),
                SizedBox(width: 3.0,),
                Icon(Icons.delete_forever, color: Colors.white,)
              ],
            ),
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: BlocConsumer<SavedArticlesBloc, SavedArticlesState>(
            cubit: savedArticlesBloc,
            builder: (context, state) {

              if(state is ArticlesFetched) {
                List<NewsArticle> reversedList = List.from(state.articles.reversed);
                print(reversedList[0].title);

                return ListView.builder(
                  itemCount: reversedList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleDetailsPage(url: reversedList[index].url, title: state.articles[index].title,)));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            calculateTimeAgo(reversedList[index].publishedAt) + ' by ' + reversedList[index].sourceName,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4,),
                          Text(
                            reversedList[index].title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                     SizedBox(height: 12,),
                     Text(
                       reversedList[index].description,
                       style: TextStyle(
                         color: Colors.grey[700],
                         fontSize: 14,
                       ),
                     ),
                          SizedBox(height: 24,),
                          Divider(color: Colors.grey[400], indent: 50, endIndent: 20,),
                          SizedBox(height: 24,),
                          // Widget to display the list of project
                        ],
                      ),
                    );
                  },
                );
              }

              if(state is NoArticlesSaved) {
                return Container(
                  child: Center(
                    child: Text(
                      'You currently have no saved articles.',
                    ),
                  ),
                );
              }

              return Container(
                height: 0,
                width: 0,
              );
            },
            listener: (context, state){},
          )
      ),
    );
  }
}

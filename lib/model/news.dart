
import 'package:rambo_news/model/newsArticle.dart';

class News {
  String newsTitle;
  List<dynamic> newsArticles = [];

  News ({this.newsTitle, this.newsArticles});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      newsTitle: json['totalResults'].toString(),
      newsArticles: json['articles'],
    );
  }
}
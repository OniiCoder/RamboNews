
import 'package:rambo_news/model/newsArticle.dart';

class NewsRepo {
  List<NewsArticle> articles = [];

  List<NewsArticle> fetchArticles() {
    return articles;
  }

  List<NewsArticle> addToArticles(NewsArticle newsArticle) {
    articles.add(newsArticle);

    return articles;
  }

  List<NewsArticle> clearArticles() {
    articles.clear();

    return articles;
  }
}
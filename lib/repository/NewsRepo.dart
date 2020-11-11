
import 'package:rambo_news/model/newsArticle.dart';

class NewsRepo {
  List<NewsArticle> articles;
  NewsRepo() {
    this.articles = [];
  }

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

  List<NewsArticle> deleteArticle(NewsArticle newsArticle) {

    for(var i=0; i<articles.length; i++) {
      if(newsArticle.url == articles[i].url) {
        articles.removeAt(i);
        break;
      }
    }

    return articles;
  }
}
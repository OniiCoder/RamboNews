import 'package:flutter_test/flutter_test.dart';
import 'package:rambo_news/model/newsArticle.dart';
import 'package:rambo_news/repository/NewsRepo.dart';

void main() {

  test('if the list of saved articles is empty when called upon, it should return an empty list still', () async {

    NewsRepo newsRepo = NewsRepo();
    newsRepo.fetchArticles();
    expect(newsRepo.articles, []);
  });
  
  test('update list of news articles with the given article', () async {
    NewsRepo newsRepo = NewsRepo();

    NewsArticle newsArticle = NewsArticle(
      sourceName: 'News source',
        author: 'author name',
        title: 'this is a title',
        description: 'a short description of news story',
        url: 'https://link.com',
        urlToImage: 'https://linkToImage',
        publishedAt: '10/11/2020'
    );
    newsRepo.addToArticles(newsArticle);
    expect(newsRepo.articles, [newsArticle]);

  });

  test('save 2 articles and delete a given article from saved list', () async {
    NewsRepo newsRepo = NewsRepo();

    // adding 2 dummy data
    NewsArticle newsArticle = NewsArticle(
        sourceName: 'News source',
        author: 'author name',
        title: 'this is a title',
        description: 'a short description of news story',
        url: 'https://link.com',
        urlToImage: 'https://linkToImage',
        publishedAt: '10/11/2020'
    );

    NewsArticle newsArticle2 = NewsArticle(
        sourceName: 'News source2',
        author: 'author name 2',
        title: 'this is title 2',
        description: 'a short description of news story 2',
        url: 'https://link2.com',
        urlToImage: 'https://linkToImage2',
        publishedAt: '9/11/2020'
    );
    newsRepo.addToArticles(newsArticle);
    newsRepo.addToArticles(newsArticle2);

    //try delete article2
    newsRepo.deleteArticle(newsArticle2);

    expect(newsRepo.articles, [newsArticle]);

  });
}

class NewsArticle {
  String sourceName, author, title, description, url, urlToImage, publishedAt;

  NewsArticle ({this.sourceName, this.author, this.title, this.description, this.url, this. urlToImage, this.publishedAt});

  factory NewsArticle.fromJson(dynamic json) {
    return NewsArticle(
      sourceName: json['source']['name'] as String,
      author: json['author'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String,
      publishedAt: json['publishedAt'] as String,
    );
  }

}
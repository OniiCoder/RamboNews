import 'package:rambo_news/model/newsArticle.dart';
import 'package:super_enum/super_enum.dart';

part 'SavedArticlesEvent.super.dart';

@superEnum
enum _SavedArticlesEvent {
  @Data(fields: [DataField<NewsArticle>('article')])
  SaveArticle,

  @object
  FetchSavedArticles,

  @object
  ClearArticles
}
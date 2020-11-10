import 'package:rambo_news/model/newsArticle.dart';
import 'package:super_enum/super_enum.dart';

part 'SavedArticlesState.super.dart';

@superEnum
enum _SavedArticlesState {
  @object
  InitialState,

  @Data(fields: [DataField<List<NewsArticle>>('articles')])
  ArticlesFetched,

  @object
  FetchingArticle,

  @object
  NoArticlesSaved
}
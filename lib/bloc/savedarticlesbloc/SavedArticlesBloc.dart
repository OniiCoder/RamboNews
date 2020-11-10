
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesEvent.dart';
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesState.dart';
import 'package:rambo_news/model/newsArticle.dart';
import 'package:rambo_news/repository/NewsRepo.dart';

class SavedArticlesBloc extends Bloc<SavedArticlesEvent, SavedArticlesState> {
  SavedArticlesBloc() : super(SavedArticlesState.initialState());
  NewsRepo newsRepo = NewsRepo();

  @override
  Stream<SavedArticlesState> mapEventToState(SavedArticlesEvent event) async* {
    // yield* event.when(saveArticle: (data) => mapToSaveArticle(data.article), fetchSavedArticles: () => mapToFetchSavedArticles());
    yield* event.when(saveArticle: (data) => mapToSaveArticle(data.article), fetchSavedArticles: () => mapToFetchSavedArticles(), clearArticles: () => mapToClearArticles());
  }

  Stream<SavedArticlesState> mapToSaveArticle(NewsArticle article) async*{
    yield SavedArticlesState.fetchingArticle();
    List<NewsArticle> articles = newsRepo.addToArticles(article);

    if(articles.length > 0) {
      yield SavedArticlesState.articlesFetched(articles: articles);
    } else {
      yield SavedArticlesState.noArticlesSaved();
    }


  }

  Stream<SavedArticlesState> mapToFetchSavedArticles() async*{
    yield SavedArticlesState.fetchingArticle();
    List<NewsArticle> articles = newsRepo.fetchArticles();
    if(articles.length > 0) {
      yield SavedArticlesState.articlesFetched(articles: articles);
    } else {
      yield SavedArticlesState.noArticlesSaved();
    }
  }

  Stream<SavedArticlesState> mapToClearArticles() async*{
    yield SavedArticlesState.fetchingArticle();
    List<NewsArticle> articles = newsRepo.clearArticles();
    if(articles.length > 0) {
      yield SavedArticlesState.articlesFetched(articles: articles);
    } else {
      yield SavedArticlesState.noArticlesSaved();
    }
  }

}
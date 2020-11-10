// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'SavedArticlesState.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class SavedArticlesState extends Equatable {
  const SavedArticlesState(this._type);

  factory SavedArticlesState.initialState() = InitialState.create;

  factory SavedArticlesState.articlesFetched(
      {@required List<NewsArticle> articles}) = ArticlesFetched.create;

  factory SavedArticlesState.fetchingArticle() = FetchingArticle.create;

  factory SavedArticlesState.noArticlesSaved() = NoArticlesSaved.create;

  final _SavedArticlesState _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _SavedArticlesState [_type]s defined.
  R when<R extends Object>(
      {@required R Function() initialState,
      @required R Function(ArticlesFetched) articlesFetched,
      @required R Function() fetchingArticle,
      @required R Function() noArticlesSaved}) {
    assert(() {
      if (initialState == null ||
          articlesFetched == null ||
          fetchingArticle == null ||
          noArticlesSaved == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _SavedArticlesState.InitialState:
        return initialState();
      case _SavedArticlesState.ArticlesFetched:
        return articlesFetched(this as ArticlesFetched);
      case _SavedArticlesState.FetchingArticle:
        return fetchingArticle();
      case _SavedArticlesState.NoArticlesSaved:
        return noArticlesSaved();
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function() initialState,
      R Function(ArticlesFetched) articlesFetched,
      R Function() fetchingArticle,
      R Function() noArticlesSaved,
      @required R Function(SavedArticlesState) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _SavedArticlesState.InitialState:
        if (initialState == null) break;
        return initialState();
      case _SavedArticlesState.ArticlesFetched:
        if (articlesFetched == null) break;
        return articlesFetched(this as ArticlesFetched);
      case _SavedArticlesState.FetchingArticle:
        if (fetchingArticle == null) break;
        return fetchingArticle();
      case _SavedArticlesState.NoArticlesSaved:
        if (noArticlesSaved == null) break;
        return noArticlesSaved();
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function() initialState,
      void Function(ArticlesFetched) articlesFetched,
      void Function() fetchingArticle,
      void Function() noArticlesSaved}) {
    assert(() {
      if (initialState == null &&
          articlesFetched == null &&
          fetchingArticle == null &&
          noArticlesSaved == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _SavedArticlesState.InitialState:
        if (initialState == null) break;
        return initialState();
      case _SavedArticlesState.ArticlesFetched:
        if (articlesFetched == null) break;
        return articlesFetched(this as ArticlesFetched);
      case _SavedArticlesState.FetchingArticle:
        if (fetchingArticle == null) break;
        return fetchingArticle();
      case _SavedArticlesState.NoArticlesSaved:
        if (noArticlesSaved == null) break;
        return noArticlesSaved();
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class InitialState extends SavedArticlesState {
  const InitialState() : super(_SavedArticlesState.InitialState);

  factory InitialState.create() = _InitialStateImpl;
}

@immutable
class _InitialStateImpl extends InitialState {
  const _InitialStateImpl() : super();

  @override
  String toString() => 'InitialState()';
}

@immutable
abstract class ArticlesFetched extends SavedArticlesState {
  const ArticlesFetched({@required this.articles})
      : super(_SavedArticlesState.ArticlesFetched);

  factory ArticlesFetched.create({@required List<NewsArticle> articles}) =
      _ArticlesFetchedImpl;

  final List<NewsArticle> articles;

  /// Creates a copy of this ArticlesFetched but with the given fields
  /// replaced with the new values.
  ArticlesFetched copyWith({List<NewsArticle> articles});
}

@immutable
class _ArticlesFetchedImpl extends ArticlesFetched {
  const _ArticlesFetchedImpl({@required this.articles})
      : super(articles: articles);

  @override
  final List<NewsArticle> articles;

  @override
  _ArticlesFetchedImpl copyWith({Object articles = superEnum}) =>
      _ArticlesFetchedImpl(
        articles: articles == superEnum
            ? this.articles
            : articles as List<NewsArticle>,
      );
  @override
  String toString() => 'ArticlesFetched(articles: ${this.articles})';
  @override
  List<Object> get props => [articles];
}

@immutable
abstract class FetchingArticle extends SavedArticlesState {
  const FetchingArticle() : super(_SavedArticlesState.FetchingArticle);

  factory FetchingArticle.create() = _FetchingArticleImpl;
}

@immutable
class _FetchingArticleImpl extends FetchingArticle {
  const _FetchingArticleImpl() : super();

  @override
  String toString() => 'FetchingArticle()';
}

@immutable
abstract class NoArticlesSaved extends SavedArticlesState {
  const NoArticlesSaved() : super(_SavedArticlesState.NoArticlesSaved);

  factory NoArticlesSaved.create() = _NoArticlesSavedImpl;
}

@immutable
class _NoArticlesSavedImpl extends NoArticlesSaved {
  const _NoArticlesSavedImpl() : super();

  @override
  String toString() => 'NoArticlesSaved()';
}

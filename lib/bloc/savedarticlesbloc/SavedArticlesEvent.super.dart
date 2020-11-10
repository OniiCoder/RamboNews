// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'SavedArticlesEvent.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class SavedArticlesEvent extends Equatable {
  const SavedArticlesEvent(this._type);

  factory SavedArticlesEvent.saveArticle({@required NewsArticle article}) =
      SaveArticle.create;

  factory SavedArticlesEvent.fetchSavedArticles() = FetchSavedArticles.create;

  factory SavedArticlesEvent.clearArticles() = ClearArticles.create;

  factory SavedArticlesEvent.deleteOneArticle({@required NewsArticle article}) =
      DeleteOneArticle.create;

  final _SavedArticlesEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _SavedArticlesEvent [_type]s defined.
  R when<R extends Object>(
      {@required R Function(SaveArticle) saveArticle,
      @required R Function() fetchSavedArticles,
      @required R Function() clearArticles,
      @required R Function(DeleteOneArticle) deleteOneArticle}) {
    assert(() {
      if (saveArticle == null ||
          fetchSavedArticles == null ||
          clearArticles == null ||
          deleteOneArticle == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _SavedArticlesEvent.SaveArticle:
        return saveArticle(this as SaveArticle);
      case _SavedArticlesEvent.FetchSavedArticles:
        return fetchSavedArticles();
      case _SavedArticlesEvent.ClearArticles:
        return clearArticles();
      case _SavedArticlesEvent.DeleteOneArticle:
        return deleteOneArticle(this as DeleteOneArticle);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function(SaveArticle) saveArticle,
      R Function() fetchSavedArticles,
      R Function() clearArticles,
      R Function(DeleteOneArticle) deleteOneArticle,
      @required R Function(SavedArticlesEvent) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _SavedArticlesEvent.SaveArticle:
        if (saveArticle == null) break;
        return saveArticle(this as SaveArticle);
      case _SavedArticlesEvent.FetchSavedArticles:
        if (fetchSavedArticles == null) break;
        return fetchSavedArticles();
      case _SavedArticlesEvent.ClearArticles:
        if (clearArticles == null) break;
        return clearArticles();
      case _SavedArticlesEvent.DeleteOneArticle:
        if (deleteOneArticle == null) break;
        return deleteOneArticle(this as DeleteOneArticle);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function(SaveArticle) saveArticle,
      void Function() fetchSavedArticles,
      void Function() clearArticles,
      void Function(DeleteOneArticle) deleteOneArticle}) {
    assert(() {
      if (saveArticle == null &&
          fetchSavedArticles == null &&
          clearArticles == null &&
          deleteOneArticle == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _SavedArticlesEvent.SaveArticle:
        if (saveArticle == null) break;
        return saveArticle(this as SaveArticle);
      case _SavedArticlesEvent.FetchSavedArticles:
        if (fetchSavedArticles == null) break;
        return fetchSavedArticles();
      case _SavedArticlesEvent.ClearArticles:
        if (clearArticles == null) break;
        return clearArticles();
      case _SavedArticlesEvent.DeleteOneArticle:
        if (deleteOneArticle == null) break;
        return deleteOneArticle(this as DeleteOneArticle);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class SaveArticle extends SavedArticlesEvent {
  const SaveArticle({@required this.article})
      : super(_SavedArticlesEvent.SaveArticle);

  factory SaveArticle.create({@required NewsArticle article}) =
      _SaveArticleImpl;

  final NewsArticle article;

  /// Creates a copy of this SaveArticle but with the given fields
  /// replaced with the new values.
  SaveArticle copyWith({NewsArticle article});
}

@immutable
class _SaveArticleImpl extends SaveArticle {
  const _SaveArticleImpl({@required this.article}) : super(article: article);

  @override
  final NewsArticle article;

  @override
  _SaveArticleImpl copyWith({Object article = superEnum}) => _SaveArticleImpl(
        article: article == superEnum ? this.article : article as NewsArticle,
      );
  @override
  String toString() => 'SaveArticle(article: ${this.article})';
  @override
  List<Object> get props => [article];
}

@immutable
abstract class FetchSavedArticles extends SavedArticlesEvent {
  const FetchSavedArticles() : super(_SavedArticlesEvent.FetchSavedArticles);

  factory FetchSavedArticles.create() = _FetchSavedArticlesImpl;
}

@immutable
class _FetchSavedArticlesImpl extends FetchSavedArticles {
  const _FetchSavedArticlesImpl() : super();

  @override
  String toString() => 'FetchSavedArticles()';
}

@immutable
abstract class ClearArticles extends SavedArticlesEvent {
  const ClearArticles() : super(_SavedArticlesEvent.ClearArticles);

  factory ClearArticles.create() = _ClearArticlesImpl;
}

@immutable
class _ClearArticlesImpl extends ClearArticles {
  const _ClearArticlesImpl() : super();

  @override
  String toString() => 'ClearArticles()';
}

@immutable
abstract class DeleteOneArticle extends SavedArticlesEvent {
  const DeleteOneArticle({@required this.article})
      : super(_SavedArticlesEvent.DeleteOneArticle);

  factory DeleteOneArticle.create({@required NewsArticle article}) =
      _DeleteOneArticleImpl;

  final NewsArticle article;

  /// Creates a copy of this DeleteOneArticle but with the given fields
  /// replaced with the new values.
  DeleteOneArticle copyWith({NewsArticle article});
}

@immutable
class _DeleteOneArticleImpl extends DeleteOneArticle {
  const _DeleteOneArticleImpl({@required this.article})
      : super(article: article);

  @override
  final NewsArticle article;

  @override
  _DeleteOneArticleImpl copyWith({Object article = superEnum}) =>
      _DeleteOneArticleImpl(
        article: article == superEnum ? this.article : article as NewsArticle,
      );
  @override
  String toString() => 'DeleteOneArticle(article: ${this.article})';
  @override
  List<Object> get props => [article];
}

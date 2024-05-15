part of 'top_headlines_news_bloc.dart';

sealed class TopHeadlinesNewsState extends Equatable {
  const TopHeadlinesNewsState();

  @override
  List<dynamic> get props => [];
}

class InitialTopHeadlinesNewsState extends TopHeadlinesNewsState {}

class LoadingTopHeadlinesNewsState extends TopHeadlinesNewsState {}

class LoadedTopHeadlinesNewsState extends TopHeadlinesNewsState {
  final List<ArticleEntity> listArticles;

  const LoadedTopHeadlinesNewsState({this.listArticles = const []});

  @override
  List<dynamic> get props => [listArticles];

  @override
  String toString() {
    return 'LoadedTopHeadlinesNewsState{listArticles: $listArticles}';
  }
}

class FailureTopHeadlinesNewsState extends TopHeadlinesNewsState {
  final String? errorMessage;

  const FailureTopHeadlinesNewsState({this.errorMessage});

  @override
  List<dynamic> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureTopHeadlinesNewsState{errorMessage: $errorMessage}';
  }
}

class ChangedCategoryTopHeadlinesNewsState extends TopHeadlinesNewsState {
  final int? indexCountrySelected;
  final int? indexCategorySelected;

  const ChangedCategoryTopHeadlinesNewsState(
      {this.indexCountrySelected, this.indexCategorySelected});

  @override
  List<dynamic> get props => [indexCountrySelected, indexCategorySelected];

  @override
  String toString() {
    return 'ChangedCategoryTopHeadlinesNewsState{indexCountrySelected: $indexCountrySelected, indexCategorySelected: $indexCategorySelected}';
  }
}

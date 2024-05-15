part of 'search_top_headlines_bloc.dart';

sealed class SearchTopHeadlinesState extends Equatable {
  const SearchTopHeadlinesState();

  @override
  List<dynamic> get props => [];
}

class SearchTopHeadlinesStateInitial extends SearchTopHeadlinesState {}

class SearchTopHeadlinesStateLoading extends SearchTopHeadlinesState {}

class SearchTopHeadlinesStateSuccess extends SearchTopHeadlinesState {
  final List<ArticleEntity> listArticles;

  const SearchTopHeadlinesStateSuccess({required this.listArticles});

  @override
  List<dynamic> get props => [listArticles];

  @override
  String toString() {
    return 'SearchTopHeadlinesStateSuccess{listArticles: $listArticles}';
  }
}

class SearchTopHeadlinesStateFailure extends SearchTopHeadlinesState {
  final String? errorMessage;

  const SearchTopHeadlinesStateFailure({this.errorMessage});

  @override
  List<dynamic> get props => [errorMessage];

  @override
  String toString() {
    return 'SearchTopHeadlinesStateFailure{errorMessage: $errorMessage}';
  }
}

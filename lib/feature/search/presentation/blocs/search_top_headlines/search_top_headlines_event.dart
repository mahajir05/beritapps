part of 'search_top_headlines_bloc.dart';

sealed class SearchTopHeadlinesEvent extends Equatable {
  const SearchTopHeadlinesEvent();

  @override
  List<dynamic> get props => [];
}

class SearchTopHeadlinesNowEvent extends SearchTopHeadlinesEvent {
  final String? countryCode;
  final String? keyword;

  const SearchTopHeadlinesNowEvent(
      {required this.countryCode, required this.keyword});

  @override
  List<dynamic> get props => [countryCode, keyword];

  @override
  String toString() {
    return 'SearchTopHeadlinesNowEvent{countryCode: $countryCode, keyword: $keyword}';
  }
}

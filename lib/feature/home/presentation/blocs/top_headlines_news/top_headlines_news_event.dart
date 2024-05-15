part of 'top_headlines_news_bloc.dart';

sealed class TopHeadlinesNewsEvent extends Equatable {
  const TopHeadlinesNewsEvent();

  @override
  List<dynamic> get props => [];
}

class LoadTopHeadlinesNewsEvent extends TopHeadlinesNewsEvent {
  final String? countryCode;
  final String? category;

  const LoadTopHeadlinesNewsEvent(
      {required this.countryCode, required this.category});

  @override
  List<dynamic> get props => [countryCode, category];

  @override
  String toString() {
    return 'LoadTopHeadlinesNewsEvent{countryCode: $countryCode, category: $category}';
  }
}

class ChangeCategoryAndCountryTopHeadlinesNewsEvent
    extends TopHeadlinesNewsEvent {
  final int? indexCountrySelected;
  final int? indexCategorySelected;

  const ChangeCategoryAndCountryTopHeadlinesNewsEvent(
      {required this.indexCountrySelected,
      required this.indexCategorySelected});

  @override
  List<dynamic> get props => [indexCategorySelected];

  @override
  String toString() {
    return 'ChangeCategoryTopHeadlinesNewsEvent{indexCountrySelected: $indexCountrySelected, indexCategorySelected: $indexCategorySelected}';
  }
}

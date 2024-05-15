part of 'home_news_helper_cubit.dart';

class HomeNewsHelperState extends Equatable {
  final int indexCountrySelected;
  final int indexCategorySelected;
  const HomeNewsHelperState(
      {required this.indexCountrySelected,
      required this.indexCategorySelected});

  HomeNewsHelperState copyWith({
    int? indexCountrySelected,
    int? indexCategorySelected,
  }) =>
      HomeNewsHelperState(
        indexCountrySelected: indexCountrySelected ?? this.indexCountrySelected,
        indexCategorySelected:
            indexCategorySelected ?? this.indexCategorySelected,
      );

  @override
  List<Object> get props => [indexCountrySelected, indexCategorySelected];
}

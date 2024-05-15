import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_news_helper_state.dart';

class HomeNewsHelperCubit extends Cubit<HomeNewsHelperState> {
  HomeNewsHelperCubit()
      : super(const HomeNewsHelperState(
          indexCountrySelected: 0,
          indexCategorySelected: 0,
        ));

  void changeCountry(int index) =>
      emit(state.copyWith(indexCountrySelected: index));

  void changeCategory(int index) =>
      emit(state.copyWith(indexCategorySelected: index));
}

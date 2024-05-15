import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/article_entity.dart';
import '../../../domain/usecase/get_top_headlines_news_uc.dart';

part 'top_headlines_news_event.dart';
part 'top_headlines_news_state.dart';

class TopHeadlinesNewsBloc
    extends Bloc<TopHeadlinesNewsEvent, TopHeadlinesNewsState> {
  final GetTopHeadlinesNewsUc getTopHeadlinesNews;

  TopHeadlinesNewsBloc({
    required this.getTopHeadlinesNews,
  }) : super(InitialTopHeadlinesNewsState()) {
    on<LoadTopHeadlinesNewsEvent>((event, emit) async {
      emit(LoadingTopHeadlinesNewsState());
      var response = await getTopHeadlinesNews(ParamsGetTopHeadlinesNews(
        countryCode: event.countryCode,
        category: event.category,
      ));
      response.fold(
        (failure) {
          if (failure is ClientFailure) {
            return emit(FailureTopHeadlinesNewsState(
                errorMessage: failure.errorMessage));
          } else if (failure is ConnectionFailure) {
            return emit(FailureTopHeadlinesNewsState(
                errorMessage: failure.errorMessage));
          } else if (failure is CacheFailure) {
            return emit(FailureTopHeadlinesNewsState(
                errorMessage: failure.errorMessage));
          } else if (failure is ServerFailure) {
            return emit(FailureTopHeadlinesNewsState(
                errorMessage: failure.errorMessage));
          }
        },
        (data) => emit(LoadedTopHeadlinesNewsState(listArticles: data)),
      );
    });

    on<ChangeCategoryAndCountryTopHeadlinesNewsEvent>((event, emit) async {
      emit(ChangedCategoryTopHeadlinesNewsState(
          indexCountrySelected: event.indexCountrySelected,
          indexCategorySelected: event.indexCategorySelected));
    });
  }
}

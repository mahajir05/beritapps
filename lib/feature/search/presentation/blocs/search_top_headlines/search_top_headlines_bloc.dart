import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/article_entity.dart';
import '../../../domain/usecases/search_top_headlines_news_uc.dart';

part 'search_top_headlines_event.dart';
part 'search_top_headlines_state.dart';

class SearchTopHeadlinesBloc
    extends Bloc<SearchTopHeadlinesEvent, SearchTopHeadlinesState> {
  final SearchTopHeadlinesNewsUc searchTopHeadlinesNews;

  SearchTopHeadlinesBloc({required this.searchTopHeadlinesNews})
      : super(SearchTopHeadlinesStateInitial()) {
    on<SearchTopHeadlinesNowEvent>((event, emit) async {
      emit(SearchTopHeadlinesStateLoading());
      var result = await searchTopHeadlinesNews(ParamsSearchTopHeadlinesNews(
          countryCode: event.countryCode, keyword: event.keyword));
      result.fold(
        (failure) {
          if (failure is ClientFailure) {
            return emit(SearchTopHeadlinesStateFailure(
                errorMessage: failure.errorMessage));
          } else if (failure is ConnectionFailure) {
            return emit(SearchTopHeadlinesStateFailure(
                errorMessage: failure.errorMessage));
          } else if (failure is CacheFailure) {
            return emit(SearchTopHeadlinesStateFailure(
                errorMessage: failure.errorMessage));
          } else if (failure is ServerFailure) {
            return emit(SearchTopHeadlinesStateFailure(
                errorMessage: failure.errorMessage));
          }
        },
        (response) =>
            emit(SearchTopHeadlinesStateSuccess(listArticles: response)),
      );
    });
  }
}

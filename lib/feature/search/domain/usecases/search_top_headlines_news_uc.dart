import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/article_entity.dart';
import '../repositories/search_repository.dart';
import '/core/error/failure.dart';
import '/core/usecase/usecase.dart';

class SearchTopHeadlinesNewsUc
    implements UseCase<List<ArticleEntity>, ParamsSearchTopHeadlinesNews> {
  final SearchRepository repository;

  SearchTopHeadlinesNewsUc({required this.repository});

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(
      ParamsSearchTopHeadlinesNews params) async {
    return await repository.searchTopHeadlinesNews(
        countryCode: params.countryCode, keyword: params.keyword);
  }
}

class ParamsSearchTopHeadlinesNews extends Equatable {
  final String? countryCode;
  final String? keyword;

  const ParamsSearchTopHeadlinesNews({this.countryCode, required this.keyword});

  @override
  List<dynamic> get props => [keyword];

  @override
  String toString() {
    return 'ParamsSearchTopHeadlinesNews{keyword: $keyword}';
  }
}

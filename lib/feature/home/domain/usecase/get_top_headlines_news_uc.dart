import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/article_entity.dart';
import '/core/error/failure.dart';
import '/core/usecase/usecase.dart';
import '../repository/news/home_repository.dart';

class GetTopHeadlinesNewsUc
    implements UseCase<List<ArticleEntity>, ParamsGetTopHeadlinesNews> {
  final HomeRepository newsRepository;

  GetTopHeadlinesNewsUc({required this.newsRepository});

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(
      ParamsGetTopHeadlinesNews params) async {
    return await newsRepository.getTopHeadlinesNews(
        countryCode: params.countryCode, category: params.category);
  }
}

class ParamsGetTopHeadlinesNews extends Equatable {
  final String? countryCode;
  final String? category;

  const ParamsGetTopHeadlinesNews({this.countryCode, required this.category});

  @override
  List<dynamic> get props => [category];

  @override
  String toString() {
    return 'ParamsGetTopHeadlinesNews{category: $category}';
  }
}

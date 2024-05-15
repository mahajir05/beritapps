import 'package:dartz/dartz.dart';
import '../../entities/article_entity.dart';
import '/core/error/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ArticleEntity>>> getTopHeadlinesNews(
      {String? countryCode = "id", String? category});
}

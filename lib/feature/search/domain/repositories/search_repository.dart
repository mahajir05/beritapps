import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/article_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<ArticleEntity>>> searchTopHeadlinesNews(
      {String? countryCode = "id", String? keyword});
}

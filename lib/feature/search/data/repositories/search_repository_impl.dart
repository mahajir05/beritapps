import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/util/app_utils.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../data_sources/search_remote_data_source.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<ArticleEntity>>> searchTopHeadlinesNews(
      {String? countryCode = "id", String? keyword}) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final result = await remoteDataSource.searchTopHeadlinesNews(
            countryCode: countryCode, keyword: keyword);
        return Right(result.data ?? []);
      } on ClientException catch (e) {
        return Left(ClientFailure(
          code: e.code,
          errorMessage: e.toString(),
          errors: e.errors,
        ));
      } on ServerException {
        return Left(ServerFailure());
      } on UnknownException catch (e) {
        return Left(UnknownFailure(e.message ?? ""));
      } catch (e) {
        appPrint("[$this][searchTopHeadlinesNews][catch] error: $e");
        return Left(UnknownFailure(e.toString()));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}

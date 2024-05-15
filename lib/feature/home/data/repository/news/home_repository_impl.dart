import 'package:dartz/dartz.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/util/util.dart';
import '../../../domain/entities/article_entity.dart';
import '/core/error/failure.dart';
import '/core/network/network_info.dart';
import '../../datasource/home_remote_data_source.dart';
import '../../../domain/repository/news/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.homeRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ArticleEntity>>> getTopHeadlinesNews(
      {String? countryCode = "id", String? category}) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final result = await homeRemoteDataSource.getTopHeadlinesNews(
            countryCode: countryCode, category: category);
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
        appPrint("[$this][getTopHeadlinesNews][catch] error: $e");
        return Left(UnknownFailure(e.toString()));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}

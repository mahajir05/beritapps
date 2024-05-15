import 'package:beritapps/core/error/exception.dart';
import 'package:beritapps/core/error/failure.dart';
import 'package:beritapps/core/models/base_list_resp.dart';
import 'package:beritapps/core/network/network_info.dart';
import 'package:beritapps/feature/home/data/datasource/home_remote_data_source.dart';
import 'package:beritapps/feature/home/data/model/article_model.dart';
import 'package:beritapps/feature/home/data/repository/news/home_repository_impl.dart';
import 'package:beritapps/feature/home/domain/entities/article_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repository_impl_test.mocks.dart';

@GenerateMocks([
  HomeRemoteDataSource,
  NetworkInfo,
])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockHomeRemoteDataSource mockHomeRemoteDataSource;
  late HomeRepositoryImpl homeRepository;

  setUpAll(() {
    mockNetworkInfo = MockNetworkInfo();
    mockHomeRemoteDataSource = MockHomeRemoteDataSource();
    homeRepository = HomeRepositoryImpl(
      networkInfo: mockNetworkInfo,
      homeRemoteDataSource: mockHomeRemoteDataSource,
    );
  });

  group('article repository', () {
    group('get articles', () {
      late List<ArticleModel> valueData;
      setUp(
        () {
          valueData = [
            ArticleModel.fromJson(const {
              "source": {"name": "name1"},
              "author": "author1",
              "title": "title1",
              "description": "description1",
              "url": "url1",
              "urlToImage": "urlToImage1",
              "publishedAt": "publishedAt1",
              "content": "content1",
            })
          ];
        },
      );
      test(
        'success 200',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => true);
          when(mockHomeRemoteDataSource.getTopHeadlinesNews(
            countryCode: "id",
            category: "business",
          )).thenAnswer((realInvocation) async => BaseListResp<ArticleModel>(
                status: "ok",
                totalResults: 1,
                message: 'SUCCESS',
                data: valueData,
              ));

          final result = await homeRepository.getTopHeadlinesNews(
            countryCode: "id",
            category: "business",
          );

          expect(result, Right<Failure, List<ArticleEntity>>(valueData));
        },
      );

      test(
        'error',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => true);
          when(mockHomeRemoteDataSource.getTopHeadlinesNews(
            countryCode: "id",
            category: "business",
          )).thenThrow(
              ClientException(400, 'The request parameter invalid', null));

          final result = await homeRepository.getTopHeadlinesNews(
            countryCode: "id",
            category: "business",
          );

          expect(result, isA<Left>());
        },
      );
    });
  });
}

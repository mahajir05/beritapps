import 'package:beritapps/core/error/failure.dart';
import 'package:beritapps/feature/home/domain/entities/article_entity.dart';
import 'package:beritapps/feature/home/domain/entities/article_source_entity.dart';
import 'package:beritapps/feature/home/domain/repository/news/home_repository.dart';
import 'package:beritapps/feature/home/domain/usecase/get_top_headlines_news_uc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_top_headlines_news_uc_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late MockHomeRepository mockHomeRepository;
  late GetTopHeadlinesNewsUc getTopHeadlinesNewsUc;
  late List<ArticleEntity> articles;

  setUpAll(() {
    mockHomeRepository = MockHomeRepository();
    getTopHeadlinesNewsUc =
        GetTopHeadlinesNewsUc(newsRepository: mockHomeRepository);
    articles = [
      const ArticleEntity(
        source: ArticleSourceEntity(name: "name1"),
        author: 'author1',
        title: 'title1',
        description: 'description1',
        url: 'url1',
        urlToImage: 'urlToImage1',
        publishedAt: 'publishedAt1',
        content: 'content1',
      ),
    ];
  });

  group('Get Articles Usecase', () {
    test(
      'Success',
      () async {
        when(mockHomeRepository.getTopHeadlinesNews(
          countryCode: "id",
          category: "business",
        )).thenAnswer((realInvocation) async => Right(articles));

        final result = await getTopHeadlinesNewsUc(
            const ParamsGetTopHeadlinesNews(
                countryCode: "id", category: "business"));

        expect(result, Right(articles));
      },
    );

    test(
      'ClientFailure',
      () async {
        when(mockHomeRepository.getTopHeadlinesNews(
          countryCode: "id",
          category: "business",
        )).thenAnswer((realInvocation) async =>
            Left(ClientFailure(code: 400, errorMessage: "client error")));

        final result = await getTopHeadlinesNewsUc(
            const ParamsGetTopHeadlinesNews(
                countryCode: "id", category: "business"));

        expect(result, isA<Left>());

        final result2 = result.fold((l) => l, (r) => r);
        expect(result2, isA<ClientFailure>());
      },
    );

    test(
      'ServerFailure',
      () async {
        when(mockHomeRepository.getTopHeadlinesNews(
          countryCode: "id",
          category: "business",
        )).thenAnswer((realInvocation) async =>
            Left(ServerFailure(code: 500, errorMessage: "server error")));

        final result = await getTopHeadlinesNewsUc(
            const ParamsGetTopHeadlinesNews(
                countryCode: "id", category: "business"));

        expect(result, isA<Left>());

        final result2 = result.fold((l) => l, (r) => r);
        expect(result2, isA<ServerFailure>());
      },
    );

    test(
      'UnknownFailure',
      () async {
        when(mockHomeRepository.getTopHeadlinesNews(
          countryCode: "id",
          category: "business",
        )).thenAnswer(
            (realInvocation) async => Left(UnknownFailure("unknown error")));

        final result = await getTopHeadlinesNewsUc(
            const ParamsGetTopHeadlinesNews(
                countryCode: "id", category: "business"));

        expect(result, isA<Left>());

        final result2 = result.fold((l) => l, (r) => r);
        expect(result2, isA<UnknownFailure>());
      },
    );
  });
}

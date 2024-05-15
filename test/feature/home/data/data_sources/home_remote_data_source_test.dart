import 'dart:convert';

import 'package:beritapps/core/error/exception.dart';
import 'package:beritapps/core/network/api_service.dart';
import 'package:beritapps/feature/home/data/datasource/home_remote_data_source.dart';
import 'package:beritapps/feature/home/data/model/article_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/network/api_service_test.mocks.dart';

void main() {
  late MockHttpClientAdapter dioAdapterMock;
  late Dio dio;
  late ApiService apiService;
  late HomeRemoteDataSourceImpl homeRemoteDataSource;

  late String responsepayload;
  late ResponseBody httpResponse;

  setUpAll(() {
    dioAdapterMock = MockHttpClientAdapter();
    dio = Dio();
    dio.httpClientAdapter = dioAdapterMock;
    apiService = ApiService(
      dio: dio,
      isForTest: true,
    );
    homeRemoteDataSource = HomeRemoteDataSourceImpl(apiService: apiService);
  });

  group('home getTopHeadlinesNews', () {
    group('[success]', () {
      setUp(() {
        responsepayload = jsonEncode({
          "status": "ok",
          "totalResults": 2,
          "message": "string",
          "articles": [
            {
              "source": {"name": "name1"},
              "author": "author1",
              "title": "title1",
              "description": "description1",
              "url": "url1",
              "urlToImage": "urlToImage1",
              "publishedAt": "publishedAt1",
              "content": "content1",
            },
            {
              "source": {"name": "name2"},
              "author": "author2",
              "title": "title2",
              "description": "description2",
              "url": "url2",
              "urlToImage": "urlToImage2",
              "publishedAt": "publishedAt2",
              "content": "content2",
            }
          ],
        });

        httpResponse = ResponseBody.fromString(
          responsepayload,
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      test('success 200', () async {
        when(dioAdapterMock.fetch(any, any, any))
            .thenAnswer((_) async => httpResponse);

        final result = await homeRemoteDataSource.getTopHeadlinesNews(
          countryCode: "id",
          category: "business",
        );
        expect(result.status, equals("ok"));
        expect(result.totalResults, equals(2));
        expect(result.message, isA<String>());
        expect(result.data, isA<List>());
        var aaa = jsonDecode(responsepayload);
        expect(
            result.data,
            equals([
              ArticleModel.fromJson(aaa['articles'][0]),
              ArticleModel.fromJson(aaa['articles'][1])
            ]));
      });
    });

    group('[failure]', () {
      setUp(() {
        responsepayload = jsonEncode({
          "status": "failed",
          "message": "The request parameter invalid",
          "errors": {
            "field": "cannot be blank",
          },
          "msg_key": "VALIDATION-ERROR"
        });
        httpResponse = ResponseBody.fromString(
          responsepayload,
          400,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      test('failure 400', () async {
        when(dioAdapterMock.fetch(any, any, any))
            .thenAnswer((_) async => httpResponse);

        try {
          await homeRemoteDataSource.getTopHeadlinesNews(
            countryCode: "id",
            category: "business",
          );
        } catch (e) {
          expect(e, isA<ClientException>());
          expect((e as ClientException).code, equals(400));
          expect((e).message, equals('The request parameter invalid'));
        }
      });
    });

    group('[failure]', () {
      setUp(() {
        responsepayload = jsonEncode({
          "status": "error",
          "message": "Something went wrong",
        });
        httpResponse = ResponseBody.fromString(
          responsepayload,
          500,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      test('failure 500', () async {
        when(dioAdapterMock.fetch(any, any, any))
            .thenAnswer((_) async => httpResponse);

        try {
          await homeRemoteDataSource.getTopHeadlinesNews(
            countryCode: "id",
            category: "business",
          );
        } catch (e) {
          expect(e, isA<ServerException>());
        }
      });
    });
  });
}

import 'package:beritapps/core/models/base_list_resp.dart';
import 'package:beritapps/feature/home/data/model/article_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Map<String, dynamic> baseResp = {};
  Map<String, dynamic> resData = {};

  setUpAll(() {
    resData = {
      "source": {"name": "name1"},
      "author": "author1",
      "title": "title1",
      "description": "description1",
      "url": "url1",
      "urlToImage": "urlToImage1",
      "publishedAt": "publishedAt1",
      "content": "content1",
    };
    baseResp = {
      "status": "ok",
      "totalResults": 2,
      "message": "string",
      "articles": [resData],
    };
  });

  group('article model', () {
    test(
      'from json',
      () {
        final result = ArticleModel.fromJson(resData);

        expect(result, isNotNull);
        expect(result.source?.name, equals("name1"));
        expect(result.author, equals("author1"));
        expect(result.title, equals('title1'));
        expect(result.description, equals('description1'));
        expect(result.url, equals('url1'));
        expect(result.urlToImage, equals('urlToImage1'));
        expect(result.publishedAt, equals('publishedAt1'));
        expect(result.content, equals('content1'));
      },
    );
    test(
      'to json',
      () {
        final fromJson = ArticleModel.fromJson(resData);
        final result = fromJson.toJson();
        expect(result, isNotNull);
        expect(result, equals(resData));
      },
    );
  });

  group('article model with base list resp', () {
    test(
      'from json',
      () {
        final result = BaseListResp<ArticleModel>.fromJson(
            baseResp, ArticleModel.fromJson);
        expect(result, isNotNull);
        expect(result.data, isA<List>());
        expect(result.data?[0].source?.name, equals("name1"));
        expect(result.data?[0].author, equals("author1"));
        expect(result.data?[0].title, equals('title1'));
        expect(result.data?[0].description, equals('description1'));
        expect(result.data?[0].url, equals('url1'));
        expect(result.data?[0].urlToImage, equals('urlToImage1'));
        expect(result.data?[0].publishedAt, equals('publishedAt1'));
        expect(result.data?[0].content, equals('content1'));
      },
    );
  });
}

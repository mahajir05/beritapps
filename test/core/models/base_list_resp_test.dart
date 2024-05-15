import 'package:beritapps/core/models/base_list_resp.dart';
import 'package:beritapps/feature/home/data/model/article_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'base resp success',
    () {
      Map<String, dynamic> resp = {
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
      };

      final result = BaseListResp.fromJson(resp, ArticleModel.fromJson);

      expect(result.status, equals("ok"));
      expect(result.totalResults, equals(2));
      expect(result.message, isA<String>());
      expect(result.data, isA<List>());
    },
  );

  test(
    'base resp failed',
    () {
      Map<String, dynamic> resp = {
        "status": "failed",
        "totalResults": 0,
        "message": "string",
        "errors": {"q": "cant be empty"}
      };

      final result = BaseListResp.fromJson(resp, ArticleModel.fromJson);

      expect(result.status, equals("failed"));
      expect(result.totalResults, equals(0));
      expect(result.message, isA<String>());
      expect(result.errors, isMap);
    },
  );
}

import 'package:beritapps/feature/home/domain/entities/article_entity.dart';
import 'package:beritapps/feature/home/domain/entities/article_source_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'article entity',
    () {
      const result = ArticleEntity(
        source: ArticleSourceEntity(name: "name1"),
        author: 'author1',
        title: 'title1',
        description: 'description1',
        url: 'url1',
        urlToImage: 'urlToImage1',
        publishedAt: 'publishedAt1',
        content: 'content1',
      );

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
}

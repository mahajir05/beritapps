import 'package:beritapps/feature/home/data/model/article_source_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Map<String, dynamic> resData = {};

  setUpAll(() {
    resData = {
      'name': "name1",
    };
  });

  group('article source model', () {
    test(
      'from json',
      () {
        final result = ArticleSourceModel.fromJson(resData);

        expect(result, isNotNull);
        expect(result.name, equals('name1'));
      },
    );
    test(
      'to json',
      () {
        final fromJson = ArticleSourceModel.fromJson(resData);
        final result = fromJson.toJson();
        expect(result, isNotNull);
        expect(result, equals(resData));
      },
    );
  });
}

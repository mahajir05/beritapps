import '../../domain/entities/article_source_entity.dart';

class ArticleSourceModel extends ArticleSourceEntity {
  const ArticleSourceModel({super.name});

  factory ArticleSourceModel.fromJson(Map<String, dynamic> json) =>
      ArticleSourceModel(
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {'name': name};
}

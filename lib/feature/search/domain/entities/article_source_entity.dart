import 'package:equatable/equatable.dart';

class ArticleSourceEntity extends Equatable {
  final String? name;

  const ArticleSourceEntity({this.name});

  @override
  List<Object?> get props => [name];
}

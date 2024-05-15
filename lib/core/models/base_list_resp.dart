class BaseListResp<T> {
  String? status;
  int? totalResults;
  String? message;
  final List<T>? data;
  Map<String, dynamic>? meta;
  Map<String, dynamic>? errors;

  BaseListResp({
    this.status,
    this.totalResults,
    this.message,
    this.data,
    this.meta,
    this.errors,
  });

  BaseListResp.fromJson(dynamic json, Function fromJsonModel)
      : status = json['status'],
        totalResults = json['totalResults'],
        message = json['message'],
        data = json['articles'] != null
            ? List<T>.from(json['articles']
                .cast<Map<String, dynamic>>()
                .map((itemsJson) => fromJsonModel(itemsJson)))
            : null,
        meta = json['meta'],
        errors = json['errors'];
}

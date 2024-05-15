class CacheException implements Exception {}

class ConnectionException implements Exception {}

class RequestCancelledException implements Exception {}

class ClientException implements Exception {
  final int? code;
  final String? message;
  final Map<String, dynamic>? errors;
  ClientException(this.code, this.message, this.errors);

  @override
  String toString() {
    if (message == null) return "Exception";
    return message!;
  }
}

class ServerException implements Exception {
  final bool isTimeout;
  ServerException({this.isTimeout = false});

  @override
  String toString() {
    return isTimeout.toString();
  }
}

class UnknownException implements Exception {
  final String? message;
  UnknownException({this.message});

  @override
  String toString() {
    return message ?? "-";
  }
}

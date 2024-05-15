import 'package:dio/dio.dart' as dio;

import 'exception.dart';

handleErrors(dio.Response response) {
  if (response.statusCode == null && response.data['code'] == null) {
    throw RequestCancelledException();
  } else {
    if (response.statusCode.toString().startsWith('4')) {
      throw ClientException(
        response.statusCode,
        response.data['message'] != null ? "${response.data['message']}" : null,
        response.data['errors'],
      );
    } else if (response.statusCode.toString().startsWith('5')) {
      throw ServerException(isTimeout: false);
    } else {
      throw UnknownException(message: response.statusMessage);
    }
  }
}

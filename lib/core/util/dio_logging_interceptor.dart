// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

import '../../config/environment.dart';

class DioLoggingInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (Environment.flavor == EFlavor.dev) {
      print(
          "--> ${options.method.isNotEmpty ? options.method.toUpperCase() : 'METHOD'} ${"${options.baseUrl}${options.path}"}");
      print('Headers:');
      options.headers.forEach((k, v) => print('$k: $v'));
      if (options.queryParameters.isNotEmpty) {
        print('queryParameters:');
        options.queryParameters.forEach((k, v) => print('$k: $v'));
      }
      if (options.data != null) {
        print('Body: ${options.data}');
      }
      print(
          "--> END ${options.method.isNotEmpty ? options.method.toUpperCase() : 'METHOD'}");
    }

    // example for add header authorization
    /*if (options.headers.containsKey(requiredToken)) {
      options.headers.remove(requiredToken);
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }*/
    return options;
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) {
    if (Environment.flavor == EFlavor.dev) {
      print(
          "<-- ${response.statusCode} ${response.requestOptions.baseUrl + response.requestOptions.path}");
      print('Headers:');
      response.headers.forEach((k, v) => print('$k: $v'));
      print('Response: ${response.data}');
      print('<-- END HTTP');
    }
    return onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (Environment.flavor == EFlavor.dev) {
      print(
          "<-- ${err.message} ${(err.response?.requestOptions != null ? ((err.response?.requestOptions.baseUrl ?? "") + (err.response?.requestOptions.path ?? "")) : 'URL')}");
      print("${err.response != null ? err.response?.data : 'Unknown Error'}");
      print('<-- End error');
    }
    return super.onError(err, handler);
  }
}

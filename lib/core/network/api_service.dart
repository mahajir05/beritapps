import 'package:dio/dio.dart';

import '../util/app_utils.dart';

class ApiService {
  final Dio dio;
  final bool isForTest;
  CancelToken cancelToken = CancelToken();

  ApiService({
    required this.dio,
    this.isForTest = false,
  }) {
    dio.options.receiveDataWhenStatusError = true;
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.sendTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.options.receiveDataWhenStatusError = true;
    dio.options.headers.addAll({Headers.acceptHeader: 'application/json'});
  }

  ApiService baseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
    return this;
  }

  ApiService addOtherHeader({required Map<String, String> headers}) {
    dio.options.headers.addAll(headers);
    return this;
  }

  Future<Response> get({
    required String apiPath,
    Map<String, dynamic>? request,
    bool useFormData = false,
    bool isUseCancelToken = true,
  }) async {
    appPrint('===> CALL API <===');
    appPrint('URL : ${dio.options.baseUrl}$apiPath');
    appPrint('Method : GET');
    appPrint("Header : ${dio.options.headers}");
    appPrint("Request : $request");
    try {
      Response response;
      response = await dio.get(
        apiPath,
        queryParameters: request,
        cancelToken: isUseCancelToken ? cancelToken : null,
      );
      appPrint('Success [METHOD GET] $apiPath');
      await appLog('Success Response : ${response.data}');
      appPrint('---');
      return response;
    } on DioException catch (e, _) {
      if (e.response?.data is Map) {
        (e.response?.data as Map).addAll(<String, dynamic>{
          "status": "error",
        });
        appPrintError('Error: [METHOD GET] $apiPath: $e');
        appPrintError('Error: $apiPath: ${e.response?.data}');
        appPrintError('---');
        return e.response!;
      } else {
        Response response = Response(
          data: {
            "error": null,
            "message": "error",
          },
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
        );
        if (cancelToken.isCancelled) {
          response = Response(
            data: {
              "error": null,
              "message": "request cancelled",
            },
            requestOptions: e.requestOptions,
            statusCode: e.response?.statusCode,
          );
        }
        appPrintError('Error: [METHOD GET] $apiPath: $e');
        appPrintError('Error: $apiPath: ${response.data}');
        appPrintError('---');
        return response;
      }
    }
  }

  Future<Response> patch({
    required String apiPath,
    Map<String, dynamic>? request,
    bool useFormData = false,
    bool isUseCancelToken = true,
  }) async {
    dio.options.headers['Content-type'] = 'application/json; charset=UTF-8';
    appPrint('===> CALL API <===');
    appPrint('URL : ${dio.options.baseUrl}$apiPath');
    appPrint('Method : PATCH');
    appPrint("Header : ${dio.options.headers}");
    appPrint("Request : $request");
    try {
      Response response;
      response = await dio.patch(
        apiPath,
        data: useFormData ? FormData.fromMap(request!) : request,
        cancelToken: isUseCancelToken ? cancelToken : null,
      );
      appPrint('Success [METHOD PATCH] $apiPath');
      await appLog('Success Response : ${response.data}');
      appPrint('---');
      return response;
    } on DioException catch (e, _) {
      if (e.response?.data is Map) {
        (e.response?.data as Map).addAll(<String, dynamic>{
          "status": "error",
        });
        appPrintError('Error: [METHOD PATCH] $apiPath: $e');
        appPrintError('Error: $apiPath: ${e.response?.data}');
        appPrintError('---');
        return e.response!;
      } else {
        Response response = Response(
          data: {
            "error": null,
            "message": "error",
          },
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
        );
        if (cancelToken.isCancelled) {
          response = Response(
            data: {
              "error": null,
              "message": "request cancelled",
            },
            requestOptions: e.requestOptions,
            statusCode: e.response?.statusCode,
          );
        }
        appPrintError('Error: [METHOD PATCH] $apiPath: $e');
        appPrintError('Error: $apiPath: ${response.data}');
        appPrintError('---');
        return response;
      }
    }
  }

  Future<Response> post({
    required String apiPath,
    Map<String, dynamic>? request,
    bool useFormData = false,
  }) async {
    appPrint('===> CALL API <===');
    appPrint('URL : ${dio.options.baseUrl}$apiPath');
    appPrint('Method : POST');
    appPrint("Header : ${dio.options.headers}");
    appPrint("Request : $request");
    try {
      Response response;
      response = await dio.post(
        apiPath,
        data: useFormData ? FormData.fromMap(request!) : request,
        cancelToken: cancelToken,
      );
      appPrint('Success [METHOD POST] $apiPath');
      appLog('Success Response : ${response.data}');
      appPrint('---');
      return response;
    } on DioException catch (e, _) {
      if (e.response?.data is Map) {
        appPrintError('Error : [METHOD POST] $apiPath: $e');
        appPrintError('Error : $apiPath: ${e.response?.data}');
        appPrintError('---');
        return e.response!;
      } else {
        Response response = Response(
          data: {
            "error": null,
            "message": "error",
          },
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
        );
        if (cancelToken.isCancelled) {
          response = Response(
            data: {
              "error": null,
              "message": "request cancelled",
            },
            requestOptions: e.requestOptions,
            statusCode: e.response?.statusCode,
          );
        }
        appPrintError('Error : [METHOD POST] $apiPath: $e');
        appPrintError('Error : $apiPath: ${e.response?.data}');
        appPrintError('---');
        return response;
      }
    }
  }

  Future<Response> postList({
    required String apiPath,
    List<Map<String, dynamic>>? request,
  }) async {
    appPrint('===> CALL API <===');
    appPrint('URL : ${dio.options.baseUrl}$apiPath');
    appPrint('Method : POST');
    appPrint("Header : ${dio.options.headers}");
    appPrint("Request : $request");
    try {
      Response response;
      response = await dio.post(
        apiPath,
        data: request,
        cancelToken: cancelToken,
      );
      appPrint('Success [METHOD POST] $apiPath');
      appLog('Success Response : ${response.data}');
      appPrint('---');
      return response;
    } on DioException catch (e, _) {
      if (e.response?.data is Map) {
        (e.response?.data as Map).addAll(<String, dynamic>{
          "status": "error",
        });
        appPrintError('Error : [METHOD POST] $apiPath: $e');
        appPrintError('Error : $apiPath: ${e.response?.data}');
        appPrintError('---');
        return e.response!;
      } else {
        Response response = Response(
          data: {
            "error": null,
            "message": "error",
          },
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
        );
        if (cancelToken.isCancelled) {
          response = Response(
            data: {
              "error": null,
              "message": "request cancelled",
            },
            requestOptions: e.requestOptions,
            statusCode: e.response?.statusCode,
          );
        }
        appPrintError('Error : [METHOD POST] $apiPath: $e');
        appPrintError('Error : $apiPath: ${e.response?.data}');
        appPrintError('---');
        return response;
      }
    }
  }

  Future<Response> put({
    required String apiPath,
    Map<String, dynamic>? request,
    bool useFormData = false,
  }) async {
    appPrint('===> CALL API <===');
    if (useFormData) {
      dio.options.headers.addAll({
        'Content-Type': 'application/x-www-form-urlencoded',
      });
    }
    appPrint('URL : ${dio.options.baseUrl}$apiPath');
    appPrint('Method : PUT');
    appPrint("Header : ${dio.options.headers}");
    appPrint("Request : $request");
    try {
      Response response;
      response = await dio.put(
        apiPath,
        data: useFormData ? FormData.fromMap(request!) : request,
        cancelToken: cancelToken,
      );
      appPrint('Success [METHOD PUT] $apiPath');
      appLog('Success Response : ${response.data}');
      appPrint('---');
      return response;
    } on DioException catch (e, _) {
      if (e.response?.data is Map) {
        (e.response?.data as Map).addAll(<String, dynamic>{
          "status": "error",
        });
        appPrintError('Error: [METHOD PUT] $apiPath: $e');
        appPrintError('Error : $apiPath: ${e.response?.data}');
        appPrintError('---');
        return e.response!;
      } else {
        Response response = Response(
          data: {
            "error": null,
            "message": "error",
          },
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
        );
        if (cancelToken.isCancelled) {
          response = Response(
            data: {
              "error": null,
              "message": "request cancelled",
            },
            requestOptions: e.requestOptions,
            statusCode: e.response?.statusCode,
          );
        }
        appPrintError('Error: [METHOD PUT] $apiPath: $e');
        appPrintError('Error : $apiPath: ${e.response?.data}');
        appPrintError('---');
        return response;
      }
    }
  }

  Future<Response> putList({
    required String apiPath,
    List<Map<dynamic, dynamic>>? request,
    bool useFormData = false,
  }) async {
    appPrint('===> CALL API <===');
    dio.options.headers.addAll({
      'Content-Type': useFormData
          ? 'application/x-www-form-urlencoded'
          : 'application/json',
    });
    appPrint('URL : ${dio.options.baseUrl}$apiPath');
    appPrint('Method : PUT');
    appPrint("Header : ${dio.options.headers}");
    appPrint("Request : $request");
    try {
      Response response;
      response = await dio.put(
        apiPath,
        data: useFormData
            ? request
                ?.map((e) => FormData.fromMap((e as Map<String, dynamic>)))
                .toList()
            : request,
        cancelToken: cancelToken,
      );
      appPrint('Success [METHOD PUT] $apiPath');
      appLog('Success Response : ${response.data}');
      appPrint('---');
      return response;
    } on DioException catch (e, _) {
      if (e.response?.data is Map) {
        (e.response?.data as Map).addAll(<String, dynamic>{
          "status": "error",
        });
        appPrintError('Error: [METHOD PUT] $apiPath: $e');
        appPrintError('Error : $apiPath: ${e.response?.data}');
        appPrintError('---');
        return e.response!;
      } else {
        Response response = Response(
          data: {
            "error": null,
            "message": "error",
          },
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
        );
        if (cancelToken.isCancelled) {
          response = Response(
            data: {
              "error": null,
              "message": "request cancelled",
            },
            requestOptions: e.requestOptions,
            statusCode: e.response?.statusCode,
          );
        }
        appPrintError('Error: [METHOD PUT] $apiPath: $e');
        appPrintError('Error : $apiPath: ${e.response?.data}');
        appPrintError('---');
        return response;
      }
    }
  }

  Future<Response> delete({
    required String apiPath,
    Map<String, dynamic>? request,
    bool useFormData = false,
  }) async {
    appPrint('===> CALL API <===');
    appPrint('URL : ${dio.options.baseUrl}$apiPath');
    appPrint('Method : DELETE');
    appPrint("Header : ${dio.options.headers}");
    appPrint("Request : $request");
    try {
      Response response;
      response = await dio.delete(
        apiPath,
        data: useFormData ? FormData.fromMap(request!) : request,
        cancelToken: cancelToken,
      );
      appPrint('Success [METHOD DELETE] $apiPath');
      appLog('Success Response : ${response.data}');
      appPrint('---');
      return response;
    } on DioException catch (e, _) {
      if (e.response?.data is Map) {
        (e.response?.data as Map).addAll(<String, dynamic>{
          "status": "error",
        });
        appPrintError('Error: [METHOD DELETE] $apiPath: $e');
        appPrintError('Error : $apiPath: ${e.response?.data}');
        appPrintError('---');
        return e.response!;
      } else {
        Response response = Response(
          data: {
            "error": null,
            "message": "error",
          },
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
        );
        if (cancelToken.isCancelled) {
          response = Response(
            data: {
              "error": null,
              "message": "request cancelled",
            },
            requestOptions: e.requestOptions,
            statusCode: e.response?.statusCode,
          );
        }
        appPrintError('Error: [METHOD DELETE] $apiPath: $e');
        appPrintError('Error : $apiPath: ${e.response?.data}');
        appPrintError('---');
        return response;
      }
    }
  }
}

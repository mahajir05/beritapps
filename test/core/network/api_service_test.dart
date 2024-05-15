import 'dart:convert';

import 'package:beritapps/core/network/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([HttpClientAdapter])
void main() {
  late MockHttpClientAdapter dioAdapterMock;
  late Dio dio;
  late ApiService apiService;

  setUpAll(() {
    dio = Dio();
    dioAdapterMock = MockHttpClientAdapter();
    dio.httpClientAdapter = dioAdapterMock;
    apiService = ApiService(
      dio: dio,
      isForTest: true,
    );
  });

  group(
    'api service',
    () {
      late String responsepayload;
      late ResponseBody httpResponse;
      setUp(() {
        responsepayload = jsonEncode({"response_code": "1000"});
        httpResponse = ResponseBody.fromString(
          responsepayload,
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });
      test(
        'GET',
        () async {
          when(dioAdapterMock.fetch(any, any, any))
              .thenAnswer((_) async => httpResponse);

          final result = await apiService.baseUrl('https://newsapi.org/v2').get(
                apiPath: '',
              );

          expect(result, isNotNull);
          expect(result, isA<Response>());
        },
      );
      test(
        'POST',
        () async {
          when(dioAdapterMock.fetch(any, any, any))
              .thenAnswer((_) async => httpResponse);

          final result =
              await apiService.baseUrl('https://newsapi.org/v2').post(
                    apiPath: '',
                  );

          expect(result, isNotNull);
          expect(result, isA<Response>());
        },
      );

      test(
        'POST LIST',
        () async {
          when(dioAdapterMock.fetch(any, any, any))
              .thenAnswer((_) async => httpResponse);

          final result =
              await apiService.baseUrl('https://newsapi.org/v2').postList(
                    apiPath: '',
                  );

          expect(result, isNotNull);
          expect(result, isA<Response>());
        },
      );

      test(
        'PUT',
        () async {
          when(dioAdapterMock.fetch(any, any, any))
              .thenAnswer((_) async => httpResponse);

          final result = await apiService.baseUrl('https://newsapi.org/v2').put(
                apiPath: '',
              );

          expect(result, isNotNull);
          expect(result, isA<Response>());
        },
      );

      test(
        'DELETE',
        () async {
          when(dioAdapterMock.fetch(any, any, any))
              .thenAnswer((_) async => httpResponse);

          final result =
              await apiService.baseUrl('https://newsapi.org/v2').delete(
                    apiPath: '',
                  );

          expect(result, isNotNull);
          expect(result, isA<Response>());
        },
      );
    },
  );
}

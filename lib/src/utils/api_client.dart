import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/src/utils/dio_logger_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final apiClient = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      contentType: 'application/json',
      responseType: ResponseType.json,
    ),
  );

  apiClient.interceptors.add(LoggerInterceptor());

  return apiClient;
});

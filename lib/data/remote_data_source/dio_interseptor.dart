import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cinema/data/local_data_source/jwt_storage.dart';

class JwtInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;

  JwtInterceptor({required this.secureStorage});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final jwt = await JwtStorage(storage: secureStorage).getJwt();
    options.headers['Authorization'] = 'Bearer $jwt';
    return handler.next(options);
  }
}

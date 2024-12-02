import 'dart:io';

import 'package:cinema/repository/models/reserve/reserve.dart';
import 'package:cinema/repository/storage/jwt_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

class ReserveRequest {
  ReserveRequest({
    required this.dio,
  });
  final Dio dio;
  final endpoint = dotenv.get('ENDPOINT');

  Future<void> reserve(Reserve reserveModel) async {
    try {
      final data = reserveModel.toJson();
      final secureStorage = GetIt.I<FlutterSecureStorage>();
      final token = await JwtStorage(storage: secureStorage).getJwt();
      await dio.post('$endpoint/api/orders/reserve',
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> buy(Reserve reserveModel) async {
    try {
      final data = reserveModel.toJson();
      final secureStorage = GetIt.I<FlutterSecureStorage>();
      final token = await JwtStorage(storage: secureStorage).getJwt();
      final response = await dio.post('$endpoint/api/orders/',
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      final id = response.data['id'];
      return id;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<File> getTicket(int id) async {
    try {
      final secureStorage = GetIt.I<FlutterSecureStorage>();
      final token = await JwtStorage(storage: secureStorage).getJwt();

      final response = await dio.get(
        '$endpoint/api/orders/$id/tickets',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          responseType: ResponseType.bytes, // Set response type to bytes
        ),
      );

      // Create a temporary file to store the image
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/ticket_$id.jpg');

      // Write the bytes to the file
      await file.writeAsBytes(response.data);

      return file;
    } catch (e) {
      throw Exception(e);
    }
  }
}

///api/orders/id/tickets


import 'dart:io';

import 'package:cinema/data/models/reserve/reserve.dart';
import 'package:cinema/data/local_data_source/jwt_storage.dart';
import 'package:cinema/repository/reserve_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

class ReserveRequest implements ReserveRepository {
  ReserveRequest({
    required this.dio,
  });
  final Dio dio;
  final endpoint = dotenv.get('ENDPOINT');

  @override
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

  @override
  Future<int> buy(Reserve reserveModel) async {
    try {
      final data = reserveModel.toJson();
      final response = await dio.post(
        '$endpoint/api/orders/',
        data: data,
      );
      final id = response.data['id'];
      return id;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
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
      if (response.data == null) {
        throw Exception('No ticket found');
      }
      final file = await _writeBytesToFile(response.data, id);

      return file;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<File> _writeBytesToFile(dynamic data, int id) async {
    // Create a temporary file to store the image
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/ticket_$id.jpg');

    // Write the bytes to the file
    await file.writeAsBytes(data);
    return file;
  }
}

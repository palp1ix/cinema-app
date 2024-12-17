import 'dart:typed_data';

import 'package:cinema/data/models/reserve/reserve.dart';
import 'package:cinema/data/local_data_source/jwt_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class ReserveRequest {
  ReserveRequest({
    required this.dio,
  });
  final Dio dio;
  final endpoint = dotenv.get('ENDPOINT');

  Future<void> reserveByReserveModel(Reserve reserveModel) async {
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

  Future<int> buyByReserveModel(Reserve reserveModel) async {
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

  Future<Uint8List> getTicketByReserveId(int id) async {
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
      final ticketPdfBytes = Uint8List.fromList(response.data);
      return ticketPdfBytes;
    } catch (e) {
      throw Exception(e);
    }
  }
}

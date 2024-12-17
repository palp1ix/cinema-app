import 'dart:typed_data';

import 'package:cinema/data/models/reserve/reserve.dart';
import 'package:cinema/data/remote_data_source/reserve_request.dart';
import 'package:cinema/domain/repository/reserve_repository.dart';
import 'package:dio/dio.dart';

class ReserverRepositoryImpl implements ReserveRepository {
  ReserverRepositoryImpl({required this.dio});

  final Dio dio;
  @override
  Future<void> buy(Reserve reserve) async {
    final reserveRequest = ReserveRequest(dio: dio);
    await reserveRequest.buyByReserveModel(reserve);
    return;
  }

  @override
  Future<Uint8List> getTicket(int idOfReserve) async {
    final reserveRequest = ReserveRequest(dio: dio);
    final ticket = await reserveRequest.getTicketByReserveId(idOfReserve);
    return ticket;
  }

  @override
  Future<void> reserve(Reserve reserve) async {
    final reserveRequest = ReserveRequest(dio: dio);
    await reserveRequest.reserveByReserveModel(reserve);
    return;
  }
}

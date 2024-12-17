import 'dart:typed_data';

import 'package:cinema/data/models/reserve/reserve.dart';

abstract interface class ReserveRepository {
  Future<void> reserve(Reserve reserve);
  Future<void> buy(Reserve reserve);
  Future<Uint8List> getTicket(int idOfReserve);
}

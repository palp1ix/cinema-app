import 'package:cinema/data/models/reserve/reserve.dart';

abstract interface class ReserveRepository {
  Future<void> reserve(Reserve reserve);
  Future<void> buy(Reserve reserve);
  Future<void> getTicket(int idOfReserve);
}

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SeatsRequest {
  SeatsRequest({
    required this.dio,
  });
  final Dio dio;
  final endpoint = dotenv.get('ENDPOINT');

  Future<List<int>> getOccupiedSeats(int sessionsId) async {
    try {
      final response =
          await dio.get('$endpoint/api/sessions/$sessionsId/occupied');
      final data = response.data as List;
      try {
        final intOccupiedSeats = data.cast<int>();
        return intOccupiedSeats;
      } catch (e) {
        final intOccupiedSeats = <int>[];
        return intOccupiedSeats;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

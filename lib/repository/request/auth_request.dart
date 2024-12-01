import 'package:cinema/repository/models/user/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthRequest {
  AuthRequest({
    required this.dio,
  });
  final Dio dio;
  final endpoint = dotenv.get('ENDPOINT');

  Future<String> signInWithEmailAndPassword(User user) async {
    try {
      final data = user.toJson();
      final response = await dio.post('$endpoint/api/auth/signin', data: data);
      return response.data['accessToken'];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> signUpWithEmailAndPassword(User user) async {
    try {
      final data = user.toJson();
      final response = await dio.post('$endpoint/api/users/create', data: data);
      return response.data['accessToken'];
    } catch (e) {
      throw Exception(e);
    }
  }
}

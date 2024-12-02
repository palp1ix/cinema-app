import 'package:cinema/repository/models/user/user.dart';
import 'package:cinema/repository/models/user/user_registration/user_registration.dart';
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

  Future<int> signUpWithEmailAndPassword(User user) async {
    try {
      final userRegistration = UserRegistration(
        username: user.username,
        email: user.username,
        password: user.password,
      );
      final data = userRegistration.toJson();
      final response = await dio.post('$endpoint/api/auth/signup', data: data);
      return response.data['id'];
    } catch (e) {
      throw Exception(e);
    }
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtStorage {
  final FlutterSecureStorage storage;

  JwtStorage({required this.storage});

  Future<void> setJwt(String jwt) async {
    await storage.write(key: "jwt", value: jwt);
  }

  Future<String> getJwt() async {
    return await storage.read(key: "jwt") ?? '';
  }

  deleteJwt() async {
    await storage.delete(key: "jwt");
    await storage.delete(key: "userId");
  }

  Future<void> setUserId(int id) async {
    await storage.write(key: "userId", value: '$id');
  }

  Future<int> getUserId() async {
    final id = await storage.read(key: "userId") ?? '0';
    return int.parse(id);
  }
}

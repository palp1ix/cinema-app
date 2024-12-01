import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtStorage {
  final FlutterSecureStorage storage;

  JwtStorage({required this.storage});

  setJwt(String jwt) async {
    await storage.write(key: "jwt", value: jwt);
  }

  getJwt() async {
    return await storage.read(key: "jwt");
  }

  deleteJwt() async {
    await storage.delete(key: "jwt");
  }
}

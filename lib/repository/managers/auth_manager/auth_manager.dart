import 'package:cinema/repository/storage/jwt_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class AuthManager {
  AuthStatus _status = AuthStatus.notLoggedIn;
  JwtStorage jwtStorage = JwtStorage(storage: GetIt.I<FlutterSecureStorage>());

  AuthStatus getStatus() {
    return _status;
  }

  Future<void> initUser() async {
    if (await jwtStorage.getJwt() != null) {
      _status = AuthStatus.loggedIn;
    }
  }

  void loggin(String token) {
    jwtStorage.setJwt(token);
    _status = AuthStatus.loggedIn;
  }

  void logout() {
    jwtStorage.deleteJwt();
    _status = AuthStatus.notLoggedIn;
  }
}

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

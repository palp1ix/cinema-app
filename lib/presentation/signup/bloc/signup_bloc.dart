import 'package:cinema/repository/managers/auth_manager/auth_manager.dart';
import 'package:cinema/repository/models/user/user.dart';
import 'package:cinema/repository/request/auth_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    final talker = GetIt.I<Talker>();
    on<SignUpWithEmailPassword>((event, emit) async {
      emit(SignUpProcced());
      try {
        final dio = GetIt.I<Dio>();
        final authRequest = AuthRequest(dio: dio);
        final jwtToken = await authRequest.signInWithEmailAndPassword(
            User(username: event.email, password: event.password));
        GetIt.I<AuthManager>().loggin(jwtToken);
        talker.log(jwtToken);
      } catch (e) {
        talker.error(
            'Something went wrong in signin proccess. Error message: $e');
      }
    });
  }
}

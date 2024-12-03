import 'package:cinema/domain/auth_manager/auth_manager.dart';
import 'package:cinema/data/models/user/user.dart';
import 'package:cinema/data/remote_data_source/auth_request.dart';
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
        final authManager = GetIt.I<AuthManager>();
        final id = await authRequest.signUpWithEmailAndPassword(
            User(username: event.email, password: event.password));
        authManager.setId(id);
        emit(SignUpSuccess());
        final jwtToken = await authRequest.signInWithEmailAndPassword(
            User(username: event.email, password: event.password));
        authManager.loggin(jwtToken);
        talker.log(jwtToken);
      } catch (e) {
        talker.error(
            'Something went wrong in signin proccess. Error message: $e');
      }
    });
  }
}

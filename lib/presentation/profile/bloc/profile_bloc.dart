import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<CheckForAuth>((event, emit) {
      // ignore: dead_code
      if (false) {
        emit(ProfileAuth());
      } else {
        emit(ProfileUnAuth());
      }
    });
  }
}

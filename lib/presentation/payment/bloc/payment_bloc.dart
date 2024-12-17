import 'dart:typed_data';

import 'package:cinema/data/models/reserve/reserve.dart';
import 'package:cinema/data/remote_data_source/reserve_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final talker = GetIt.I<Talker>();
  PaymentBloc() : super(PaymentInitial()) {
    on<PayEvent>((event, emit) async {
      await _onPayEvent(emit, event);
    });
  }

  Future<void> _onPayEvent(Emitter<PaymentState> emit, PayEvent event) async {
    emit(PaymentInProgress());
    try {
      // FIXME: Delete this delay
      await Future.delayed(const Duration(seconds: 1));
      final reserveRequest = ReserveRequest(dio: GetIt.I<Dio>());
      final id = await reserveRequest.buyByReserveModel(event.reserve);
      final ticket = await reserveRequest.getTicketByReserveId(id);
      emit(PaymentSuccessed(
        ticket: ticket,
      ));
    } catch (e, st) {
      talker.handle(e, st);
      emit(PaymentError(e.toString()));
    }
  }
}

part of 'payment_bloc.dart';

sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentInProgress extends PaymentState {}

final class PaymentSuccessed extends PaymentState {
  final Uint8List ticket;

  PaymentSuccessed({required this.ticket});
}

final class PaymentError extends PaymentState {
  final String message;
  PaymentError(this.message);
}

part of 'payment_bloc.dart';

sealed class PaymentEvent {}

final class PayEvent extends PaymentEvent {
  final Reserve reserve;

  PayEvent({required this.reserve});
}

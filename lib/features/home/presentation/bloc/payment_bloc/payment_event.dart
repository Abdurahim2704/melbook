part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {
  const PaymentEvent();
}

class CreatePayment extends PaymentEvent {
  final String bookId;

  const CreatePayment({required this.bookId});
}

class CheckPayment extends PaymentEvent {}

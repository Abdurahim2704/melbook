part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent extends Equatable {
  const PaymentEvent();
}

class CreatePayment extends PaymentEvent {
  final String bookId;

  const CreatePayment({required this.bookId});

  @override
  List<Object?> get props => [bookId];
}

class CheckPayment extends PaymentEvent {
  final int times;

  const CheckPayment({required this.times});

  @override
  List<Object?> get props => [times];
}

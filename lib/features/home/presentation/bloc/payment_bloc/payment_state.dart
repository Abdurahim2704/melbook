part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {
  final String message;

  const PaymentState({
    required this.message,
  });
}

final class PaymentInitial extends PaymentState {
  PaymentInitial({required super.message});
}

class PaymentLoading extends PaymentState {
  PaymentLoading({required super.message});
}

class PaymentFaillure extends PaymentState {
  const PaymentFaillure({required super.message});
}

class PaymentCreated extends PaymentState {
  final int paymentUid;

  const PaymentCreated({required this.paymentUid, required super.message});
}

class PaymentSuccess extends PaymentState {
  const PaymentSuccess({required super.message});
}

class PaymentCanceled extends PaymentState {
  const PaymentCanceled({required super.message});
}

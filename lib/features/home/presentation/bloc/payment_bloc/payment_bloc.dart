import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';
import 'package:melbook/features/home/data/service/payment_service.dart';
import 'package:meta/meta.dart';

import '../../../../../locator.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentInitial(message: '')) {
    on<CreatePayment>(_createPayment);
    on<CheckPayment>(_checkPayment);
  }

  Future<void> _createPayment(
      CreatePayment event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading(message: state.message));
    try {
      final service = PaymentService();
      // await getIt<AuthRepository>().resetToken();

      final phone = getIt<AuthRepository>().user!.phoneNumber;
      final token = getIt<AuthRepository>().token;
      final result = await service.createPayment(
          bookId: event.bookId, phoneNumber: phone, token: token);
      emit(PaymentCreated(
          paymentUid: int.parse(result.paymentUuid),
          message:
              "To'lov uchun so'rov yuborildi. Click ilovasini tekshiring."));
    } catch (e) {
      emit(PaymentFaillure(message: e.toString()));
    }
  }

  Future<void> _checkPayment(
      CheckPayment event, Emitter<PaymentState> emit) async {
    if (state is PaymentCreated) {
      try {
        final service = PaymentService();
        // await getIt<AuthRepository>().resetToken();
        print("I am now bloc");
        final result = await service.checkPayment(
            id: (state as PaymentCreated).paymentUid.toString(),
            token: getIt<AuthRepository>().token);
        print(result?.status);
        switch (result?.status) {
          case null:
            emit(const PaymentCanceled(message: "To'lov bekor qilingan"));
            return;
          case 0:
            emit(PaymentCreated(
                paymentUid: (state as PaymentCreated).paymentUid,
                message: state.message));
            return;
          default:
            emit(const PaymentSuccess(message: "To'lov amalga oshirildi"));
            return;
        }
      } catch (e) {
        emit(PaymentFaillure(message: e.toString()));
      }
    }
  }
}
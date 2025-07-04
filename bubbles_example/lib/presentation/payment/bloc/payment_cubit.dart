import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/process_payment.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final ProcessPayment _processPayment;

  PaymentCubit({required ProcessPayment processPayment})
    : _processPayment = processPayment,
      super(PaymentInitial());

  Future<void> submitPayment() async {
    emit(PaymentProcessing());
    try {
      final transactionId = await _processPayment.execute();
      emit(PaymentSuccess(transactionId: transactionId));
    } catch (e) {
      emit(PaymentFailure(message: e.toString()));
    }
  }

  void reset() {
    emit(PaymentInitial());
  }
}

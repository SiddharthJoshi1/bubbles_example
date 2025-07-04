import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentProcessing extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String transactionId;
  const PaymentSuccess({required this.transactionId});
  @override
  List<Object> get props => [transactionId];
}

class PaymentFailure extends PaymentState {
  final String message;
  const PaymentFailure({required this.message});
  @override
  List<Object> get props => [message];
}

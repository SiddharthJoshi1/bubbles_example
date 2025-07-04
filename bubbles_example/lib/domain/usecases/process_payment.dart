import '../../data/repos/payment_repo.dart';

class ProcessPayment {
  final PaymentRepository repository;

  ProcessPayment({required this.repository});

  Future<String> execute() {
    return repository.processPayment();
  }
}

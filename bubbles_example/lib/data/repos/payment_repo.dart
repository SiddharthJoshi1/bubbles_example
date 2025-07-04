import '../datasources/payment_remote_datasource.dart' show PaymentRemoteDataSource;

abstract class PaymentRepository {
  Future<String> processPayment();
}



class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> processPayment() {
    // Here you could add logic to catch specific exceptions and
    // convert them to domain-specific errors.
    return remoteDataSource.processPayment();
  }
}
import 'dart:math';

class PaymentRemoteDataSource {
  Future<String> processPayment() async {
    // Simulate a network delay of 1 to 2 seconds
    await Future.delayed(Duration(milliseconds: 1000 + Random().nextInt(1000)));

    // Simulate a random success or failure
    if (Random().nextBool()) {
      // Success
      return 'txn_${DateTime.now().millisecondsSinceEpoch}';
    } else {
      // Failure
      throw Exception('Payment Declined by Bank');
    }
  }
}

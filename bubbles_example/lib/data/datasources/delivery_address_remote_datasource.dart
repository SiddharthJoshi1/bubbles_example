
import '../../domain/entities/delivery_address.dart';

class DeliveryAddressRemoteDataSource {
  // In a real app, this would make an API call.
  Future<DeliveryAddress> confirmAddress(String address) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));

    // Basic validation (replace with more robust validation)
    if (address.isEmpty) {
      throw Exception("Address cannot be empty.");
    }

    // Mock success response
    return DeliveryAddress(address: address, city: 'Slough', country: 'UK');
  }
}

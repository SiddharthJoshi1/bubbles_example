import '../../domain/entities/delivery_address.dart';
import '../datasources/delivery_address_remote_datasource.dart';

abstract class DeliveryAddressRepository {
  Future<DeliveryAddress> confirmAddress(String address);
}


class DeliveryAddressRepositoryImpl implements DeliveryAddressRepository {
  final DeliveryAddressRemoteDataSource remoteDataSource;

  DeliveryAddressRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DeliveryAddress> confirmAddress(String address) async {
    try {
      return await remoteDataSource.confirmAddress(address);
    } catch (e) {
      // Handle exceptions (e.g., network errors, server errors)
      print("Error confirming address: $e");
      rethrow; // Re-throw for now.  Later we'll convert to a domain-specific error.
    }
  }
}
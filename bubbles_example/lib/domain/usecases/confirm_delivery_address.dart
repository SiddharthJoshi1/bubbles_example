

import '../../data/repos/delivery_address_repo.dart';
import '../entities/delivery_address.dart';

class ConfirmDeliveryAddress {
  final DeliveryAddressRepository addressRepository;

  ConfirmDeliveryAddress({required this.addressRepository});

  Future<DeliveryAddress> execute(String address) {
    return addressRepository.confirmAddress(address);
  }
}

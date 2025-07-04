import 'package:equatable/equatable.dart';

class DeliveryAddress extends Equatable {
  final String address;
  final String?
  postalCode; // Nullable in case the service doesn't always require it
  final String? city; // Nullable for the same reason
  final String? country; // Nullable for the same reason

  const DeliveryAddress({
    required this.address,
    this.postalCode,
    this.city,
    this.country,
  });

  @override
  List<Object?> get props => [address, postalCode, city, country];

  @override
  String toString() {
    return address; // For easier debugging and display
  }
}
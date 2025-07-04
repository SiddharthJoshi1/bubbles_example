import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String id;
  final double totalAmount;
  final String status; // e.g., "pending", "confirmed", "shipped", "delivered"

  const Order({
    required this.id,
    required this.totalAmount,
    required this.status,
  });

  @override
  List<Object?> get props => [id, totalAmount, status];
}

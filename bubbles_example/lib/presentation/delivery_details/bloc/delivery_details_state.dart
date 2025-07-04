import 'package:equatable/equatable.dart';

abstract class DeliveryDetailsState extends Equatable {
  const DeliveryDetailsState();
  @override
  List<Object?> get props => [];
}

// State when the screen is first shown, before any user interaction.
class DeliveryDetailsInitial extends DeliveryDetailsState {}

// State while we are actively validating the address (e.g., calling an API).
class DeliveryDetailsLoading extends DeliveryDetailsState {}

// State when the address is successfully verified and confirmed.
// This is the "signal" state that tells the orchestrator we are done.
class DeliveryDetailsSuccess extends DeliveryDetailsState {
  final String confirmedAddress;
  final double finalDeliveryFee;

  const DeliveryDetailsSuccess({
    required this.confirmedAddress,
    required this.finalDeliveryFee,
  });

  @override
  List<Object?> get props => [confirmedAddress, finalDeliveryFee];
}

// State when something went wrong during verification.
// The user can see the error and try again.
class DeliveryDetailsError extends DeliveryDetailsState {
  final String message;

  const DeliveryDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

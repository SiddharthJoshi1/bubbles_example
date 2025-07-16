import 'package:equatable/equatable.dart';

// Abstract base class
abstract class DeliveryJourneyOrchestrationState extends Equatable {
  const DeliveryJourneyOrchestrationState();
  @override
  List<Object?> get props => [];
}

// Initial state, before the journey has truly begun.
class DeliveryJourneyOrchestrationStateInitial
    extends DeliveryJourneyOrchestrationState {}

// State to show the Basket "Bubble"
class DeliveryJourneyOrchestrationStateBasket
    extends DeliveryJourneyOrchestrationState {}

// State to show the Delivery Details "Bubble"
class DeliveryJourneyOrchestrationStateDeliveryDetails
    extends DeliveryJourneyOrchestrationState {}

// State to show the Payment "Bubble"
class DeliveryJourneyOrchestrationStatePayment
    extends DeliveryJourneyOrchestrationState {}

// State to show a final success screen for the entire journey
class DeliveryJourneyOrchestrationStateSuccess
    extends DeliveryJourneyOrchestrationState {}

// State for a fatal, unrecoverable error in the journey
class DeliveryJourneyOrchestrationStateFatalFailure
    extends DeliveryJourneyOrchestrationState {}

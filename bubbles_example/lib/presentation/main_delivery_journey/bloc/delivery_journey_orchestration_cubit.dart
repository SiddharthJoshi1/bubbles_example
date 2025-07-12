import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/journey_type.dart';
import 'delivery_journey_orchestration_state.dart';

class DeliveryJourneyOrchestrationCubit
    extends Cubit<DeliveryJourneyOrchestrationState> {
  late Bubbles bubbleType;

  final List<Bubbles> bubbleOrder = [
    Bubbles.basket,
    Bubbles.deliverydetails,
    Bubbles.payment,
    Bubbles.completed,
  ];

  final Map<Bubbles, DeliveryJourneyOrchestrationState> bubbleStatesMapping = {
    Bubbles.basket: DeliveryJourneyOrchestrationStateBasket(),
    Bubbles.deliverydetails:
        DeliveryJourneyOrchestrationStateDeliveryDetails(),
    Bubbles.payment: DeliveryJourneyOrchestrationStatePayment(),
    Bubbles.completed: DeliveryJourneyOrchestrationStateSuccess(),
  };

  DeliveryJourneyOrchestrationCubit()
    : super(DeliveryJourneyOrchestrationStateInitial()) {
    // When the orchestrator is created, kick off the journey
    startJourney();
  }

  void startJourney() {
    bubbleType = bubbleOrder.first;
    emit(bubbleStatesMapping[bubbleType]!);
  }

  void goToNextJourneyStep() {
    if (bubbleOrder.indexOf(bubbleType) == bubbleOrder.length - 1) {
      handleFatalError();
      return;
    }
    bubbleType = bubbleOrder[bubbleOrder.indexOf(bubbleType) + 1];
    emit(bubbleStatesMapping[bubbleType]!);
  }

  void goToPreviousJourneyStep() {
    if (bubbleOrder.indexOf(bubbleType) == 0) {
      handleFatalError();
      return;
    }
    bubbleType = bubbleOrder[bubbleOrder.indexOf(bubbleType) - 1];
    emit(bubbleStatesMapping[bubbleType]!);
  }

  void handleFatalError() {
    print("ORCHESTRATOR: A fatal error occurred.");
    emit(DeliveryJourneyOrchestrationStateFatalFailure());
  }
}

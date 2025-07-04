import 'package:flutter_bloc/flutter_bloc.dart';
import 'delivery_journey_orchestration_state.dart';

class DeliveryJourneyOrchestrationCubit
    extends Cubit<DeliveryJourneyOrchestrationState> {
  DeliveryJourneyOrchestrationCubit()
    : super(DeliveryJourneyOrchestrationStateInitial()) {
    // When the orchestrator is created, kick off the journey
    startJourney();
  }

  void startJourney() {
    // The first step in our journey is the basket.
    emit(DeliveryJourneyOrchestrationStateBasket());
  }

  void goToDeliveryDetails() {
    print("ORCHESTRATOR: Moving to Delivery Details");
    emit(DeliveryJourneyOrchestrationStateDeliveryDetails());
  }

  void goToPayment() {
    print("ORCHESTRATOR: Moving to Payment");
    emit(DeliveryJourneyOrchestrationStatePayment());
  }

  void completeJourney() {
    print("ORCHESTRATOR: Journey complete!");
    emit(DeliveryJourneyOrchestrationStateSuccess());
  }

  void handleFatalError() {
    print("ORCHESTRATOR: A fatal error occurred.");
    emit(DeliveryJourneyOrchestrationStateFatalFailure());
  }

  // A method to go back a step, useful for user navigation
  void backToBasket() {
    print("ORCHESTRATOR: Going back to Basket");
    emit(DeliveryJourneyOrchestrationStateBasket());
  }
}

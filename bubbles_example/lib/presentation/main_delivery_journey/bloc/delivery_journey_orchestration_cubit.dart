import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/journey_type.dart';
import 'delivery_journey_orchestration_state.dart';

class DeliveryJourneyOrchestrationCubit
    extends Cubit<DeliveryJourneyOrchestrationState> {
  late JourneyType journeyType;

  final List<JourneyType> journeyOrder = [
    JourneyType.basket,
    JourneyType.deliverydetails,
    JourneyType.payment,
    JourneyType.completed,
  ];

  final Map<JourneyType, DeliveryJourneyOrchestrationState> journeyStates = {
    JourneyType.basket: DeliveryJourneyOrchestrationStateBasket(),
    JourneyType.deliverydetails:
        DeliveryJourneyOrchestrationStateDeliveryDetails(),
    JourneyType.payment: DeliveryJourneyOrchestrationStatePayment(),
    JourneyType.completed: DeliveryJourneyOrchestrationStateSuccess(),
  };

  DeliveryJourneyOrchestrationCubit()
    : super(DeliveryJourneyOrchestrationStateInitial()) {
    // When the orchestrator is created, kick off the journey
    startJourney();
  }

  void startJourney() {
    journeyType = journeyOrder.first;
    emit(journeyStates[journeyType]!);
  }

  void goToNextJourneyStep() {
    if (journeyOrder.indexOf(journeyType) == journeyOrder.length - 1) {
      handleFatalError();
      return;
    }
    journeyType = journeyOrder[journeyOrder.indexOf(journeyType) + 1];
    emit(journeyStates[journeyType]!);
  }

  void goToPreviousJourneyStep() {
    if (journeyOrder.indexOf(journeyType) == 0) {
      handleFatalError();
      return;
    }
    journeyType = journeyOrder[journeyOrder.indexOf(journeyType) - 1];
    emit(journeyStates[journeyType]!);
  }

  void handleFatalError() {
    print("ORCHESTRATOR: A fatal error occurred.");
    emit(DeliveryJourneyOrchestrationStateFatalFailure());
  }
}

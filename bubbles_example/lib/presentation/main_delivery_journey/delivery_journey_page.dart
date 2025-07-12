import 'dart:convert';

import 'package:bubbles_example/domain/entities/journey_type.dart';
import 'package:bubbles_example/injection_container.dart';
import 'package:bubbles_example/presentation/payment/widget/payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../delivery_details/bloc/delivery_details_cubit.dart';

import '../delivery_details/view/delivery_details_confirmation_widget.dart'
    show DeliveryDetailsConfirmationView;
import 'bloc/delivery_journey_orchestration_cubit.dart';
import 'bloc/delivery_journey_orchestration_state.dart';

class DeliveryJourneyPage extends StatelessWidget {
  const DeliveryJourneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Delivery Journey")),
      // BlocBuilder will rebuild the UI in response to new states from the Orchestrator
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<DeliveryJourneyOrchestrationCubit>(),
          ),
          BlocProvider(create: (context) => getIt<DeliveryDetailsCubit>()),
        ],
        child: BlocBuilder<
          DeliveryJourneyOrchestrationCubit,
          DeliveryJourneyOrchestrationState
        >(
          builder: (context, state) {
            // A switch statement cleanly maps each high-level state to a UI "bubble".
            switch (state) {
              case DeliveryJourneyOrchestrationStateBasket():
                // For now, a placeholder for the basket bubble
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("This is the Basket Bubble"),
                      ElevatedButton(
                        onPressed:
                            () =>
                                context
                                    .read<DeliveryJourneyOrchestrationCubit>()
                                    .goToNextJourneyStep(),
                        child: const Text("Proceed to Delivery Details"),
                      ),
                    ],
                  ),
                );

              case DeliveryJourneyOrchestrationStateDeliveryDetails():
                // Here we render the actual Delivery Details bubble.
                return const DeliveryDetailsConfirmationView();

              case DeliveryJourneyOrchestrationStatePayment():
                // Placeholder for the payment bubble
                return const PaymentWidget();

              case DeliveryJourneyOrchestrationStateSuccess():
                return const Center(child: Text("🎉 Order Confirmed! 🎉"));

              case DeliveryJourneyOrchestrationStateFatalFailure():
                return const Center(
                  child: Text("Something went terribly wrong."),
                );

              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

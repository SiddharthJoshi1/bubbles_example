import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import '../../main_delivery_journey/bloc/delivery_journey_orchestration_cubit.dart';
import '../bloc/delivery_details_cubit.dart';
import '../bloc/delivery_details_state.dart';

class DeliveryDetailsConfirmationView extends StatelessWidget {
  const DeliveryDetailsConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide this bubble's specific Cubit. It gets its dependencies from our
    // service locator 'getIt'. This Cubit will be disposed automatically when
    // this view is removed from the widget tree.
    return BlocProvider(
      create: (context) => getIt<DeliveryDetailsCubit>(),
      child: const _DeliveryDetailsForm(),
    );
  }
}

class _DeliveryDetailsForm extends StatefulWidget {
  const _DeliveryDetailsForm();

  @override
  State<_DeliveryDetailsForm> createState() => _DeliveryDetailsFormState();
}

class _DeliveryDetailsFormState extends State<_DeliveryDetailsForm> {
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // BlocConsumer is perfect here. It lets us react to state changes (listener)
    // and rebuild the UI (builder) in one widget.
    return BlocConsumer<DeliveryDetailsCubit, DeliveryDetailsState>(
      // The LISTENER handles "side-effects" that happen ONCE per state change,
      // like showing a SnackBar or navigating. This is where the hand-off occurs.
      listener: (context, state) {
        if (state is DeliveryDetailsSuccess) {
          // *** THE ORCHESTRATION HAND-OFF ***
          // This bubble's job is done! It "calls the parent" orchestrator
          // to tell it to move to the next step in the journey.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Address Confirmed: ${state.confirmedAddress}'),
              backgroundColor: Colors.green,
            ),
          );
          // Tell the orchestrator to proceed to the payment bubble.
          context.read<DeliveryJourneyOrchestrationCubit>().goToPayment();
        } else if (state is DeliveryDetailsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
          // After showing the error, we might want to reset the state
          // so the user isn't stuck looking at a loading spinner.
          context.read<DeliveryDetailsCubit>().reset();
        }
      },
      // The BUILDER rebuilds the UI based on the current state.
      builder: (context, state) {
        final isLoading = state is DeliveryDetailsLoading;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter Your Delivery Address',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Street Address',
                  border: OutlineInputBorder(),
                ),
                enabled: !isLoading,
              ),
              const SizedBox(height: 20),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Trigger the confirmation logic in this bubble's own cubit.
                    context.read<DeliveryDetailsCubit>().confirmAddress(
                      _addressController.text,
                    );
                  },
                  child: const Text('CONFIRM ADDRESS'),
                ),
              const SizedBox(height: 10),
              TextButton(
                onPressed:
                    isLoading
                        ? null
                        : () {
                          // This button also talks to the orchestrator to go backwards.
                          context
                              .read<DeliveryJourneyOrchestrationCubit>()
                              .backToBasket();
                        },
                child: const Text('Back to Basket'),
              ),
            ],
          ),
        );
      },
    );
  }
}

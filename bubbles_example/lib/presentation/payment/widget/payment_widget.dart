import 'package:bubbles_example/domain/entities/journey_type.dart';
import 'package:bubbles_example/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../main_delivery_journey/bloc/delivery_journey_orchestration_cubit.dart';
import '../bloc/payment_cubit.dart';
import '../bloc/payment_state.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaymentCubit>(),
      child: const _PaymentForm(),
    );
  }
}

class _PaymentForm extends StatelessWidget {
  const _PaymentForm();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          // *** THE ORCHESTRATION HAND-OFF ***
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Payment Successful! TXN ID: ${state.transactionId}',
              ),
              backgroundColor: Colors.green,
            ),
          );
          // This bubble is done. Tell the orchestrator to complete the journey.
          context.read<DeliveryJourneyOrchestrationCubit>().goToNextJourneyStep();
        } else if (state is PaymentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment Failed: ${state.message}'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
          context.read<PaymentCubit>().reset();
        }
      },
      builder: (context, state) {
        final isProcessing = state is PaymentProcessing;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter Payment Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // WARNING: This is for demonstration purposes ONLY.
              // Never handle real card data this way. Use a payment gateway SDK.
              TextField(
                decoration: const InputDecoration(labelText: 'Card Number'),
                keyboardType: TextInputType.number,
                enabled: !isProcessing,
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(labelText: 'CVV'),
                keyboardType: TextInputType.number,
                enabled: !isProcessing,
              ),
              const SizedBox(height: 20),
              if (isProcessing)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => context.read<PaymentCubit>().submitPayment(),
                  child: const Text('PAY NOW'),
                ),
              const SizedBox(height: 10),
              TextButton(
                onPressed:
                    isProcessing
                        ? null
                        : () {
                          // Go back to the previous step in the journey
                          context
                              .read<DeliveryJourneyOrchestrationCubit>()
                              .goToPreviousJourneyStep();
                        },
                child: const Text('Back to Delivery Details'),
              ),
            ],
          ),
        );
      },
    );
  }
}

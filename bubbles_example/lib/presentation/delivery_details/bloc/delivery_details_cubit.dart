import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/delivery_address.dart';
import '../../../domain/usecases/confirm_delivery_address.dart';
import 'delivery_details_state.dart';

class DeliveryDetailsCubit extends Cubit<DeliveryDetailsState> {
  // It depends on the use case from the domain layer.
  final ConfirmDeliveryAddress _confirmDeliveryAddress;

  DeliveryDetailsCubit({required ConfirmDeliveryAddress confirmDeliveryAddress})
    : _confirmDeliveryAddress = confirmDeliveryAddress,
      super(DeliveryDetailsInitial());

  // This is the main action this bubble can perform.
  Future<void> confirmAddress(String address) async {
    if (address.isEmpty) {
      emit(const DeliveryDetailsError("Address cannot be empty."));
      return;
    }

    emit(DeliveryDetailsLoading()); // Inform the UI we are busy.

    try {
      // Execute the business logic.
      final DeliveryAddress confirmedAddress = await _confirmDeliveryAddress
          .execute(address);

      // In a real app, fee calculation would be more complex.
      const double finalFee = 15.50;

      // Emit the success state with the result. This is the goal!
      emit(
        DeliveryDetailsSuccess(
          confirmedAddress: confirmedAddress.address,
          finalDeliveryFee: finalFee,
        ),
      );
    } catch (e) {
      // If the use case throws an error, we catch it and inform the UI.
      emit(
        DeliveryDetailsError(
          "Failed to verify address. Please try again. Error: $e",
        ),
      );
    }
  }

  // A helper method to reset the state if needed, e.g., after an error.
  void reset() {
    emit(DeliveryDetailsInitial());
  }
}

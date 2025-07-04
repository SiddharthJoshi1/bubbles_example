import 'package:bubbles_example/data/datasources/payment_remote_datasource.dart';
import 'package:bubbles_example/presentation/main_delivery_journey/bloc/delivery_journey_orchestration_cubit.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/delivery_address_remote_datasource.dart';
import 'data/repos/delivery_address_repo.dart';
import 'data/repos/payment_repo.dart';
import 'domain/usecases/confirm_delivery_address.dart';
import 'domain/usecases/process_payment.dart';
import 'presentation/delivery_details/bloc/delivery_details_cubit.dart';
import 'presentation/payment/bloc/payment_cubit.dart';

final getIt = GetIt.instance; // getIt is service locator

Future<void> init() async {
 // BLoCs / Cubits
  getIt.registerFactory(() => DeliveryJourneyOrchestrationCubit());
  getIt.registerFactory(() => DeliveryDetailsCubit(confirmDeliveryAddress: getIt()));
  // Add the new PaymentCubit factory
  getIt.registerFactory(() => PaymentCubit(processPayment: getIt()));

  // Use Cases
  getIt.registerFactory<ConfirmDeliveryAddress>(() => ConfirmDeliveryAddress(addressRepository: getIt()));
  // Add the new ProcessPayment use case
  getIt.registerFactory<ProcessPayment>(() => ProcessPayment(repository: getIt()));

  // Repositories
  getIt.registerLazySingleton<DeliveryAddressRepository>(() => DeliveryAddressRepositoryImpl(remoteDataSource: getIt()));
  // Add the new PaymentRepository singleton
  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(remoteDataSource: getIt()),
  );

  // Data Sources
  getIt.registerLazySingleton(() => DeliveryAddressRemoteDataSource());
  // Add the new PaymentRemoteDataSource singleton
   getIt.registerLazySingleton(() => PaymentRemoteDataSource());
}
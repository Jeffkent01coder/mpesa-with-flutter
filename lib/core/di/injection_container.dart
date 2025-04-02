import 'package:get_it/get_it.dart';

import '../../data/datasources/mpesa_data_source.dart';
import '../../data/repositories/payment_repository_impl.dart';
import '../../domain/repositories/payment_repository.dart';
import '../../domain/usecases/process_payment_usecase.dart';
import '../../presentation/providers/payment_provider.dart';

final sl = GetIt.instance;

void init() {
  // Presentation layer
  sl.registerFactory(
    () => PaymentProvider(sl()),
  );

  // Domain layer - Use cases
  sl.registerLazySingleton(() => ProcessPaymentUseCase(sl()));

  // Domain layer - Repositories
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(sl()),
  );

  // Data layer - Data sources
  sl.registerLazySingleton<MpesaDataSource>(
    () => MpesaDataSourceImpl(),
  );

  // Initialize M-PESA
  final mpesaDataSource = sl<MpesaDataSource>() as MpesaDataSourceImpl;
  mpesaDataSource.initialize();
}
import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/mpesa_data_source.dart';
import '../models/payment_model.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final MpesaDataSource dataSource;

  PaymentRepositoryImpl(this.dataSource);

  @override
  Future<PaymentResult> initiatePayment(Payment payment) async {
    try {
      // Convert domain entity to data model
      final paymentModel = PaymentModel.fromEntity(payment);

      // Call data source
      final result = await dataSource.initiateSTKPush(paymentModel);

      if (result['success']) {
        return PaymentResult.success(
          'Please check your phone for the STK push prompt',
          data: result['data'],
        );
      } else {
        return PaymentResult.failure(result['message']);
      }
    } catch (e) {
      return PaymentResult.failure('An error occurred: ${e.toString()}');
    }
  }
}
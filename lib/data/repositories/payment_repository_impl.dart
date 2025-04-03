import 'package:mpesa/domain/repositories/payment_repository.dart';
import '../../domain/entities/payment.dart';
import '../datasources/mpesa_data_source.dart';
import '../models/payment_model.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final MpesaDataSource dataSource;

  PaymentRepositoryImpl(this.dataSource);

  @override
  Future<PaymentResult> initiatePayment(Payment payment) async {
    try {
      final paymentModel = PaymentModel.fromEntity(payment);
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

  @override
  Future<PaymentResult> checkPaymentStatus(String checkoutRequestId) async {
    try {
      final result = await dataSource.queryTransactionStatus(checkoutRequestId);
      if (result['success']) {
        return PaymentResult.success('Status checked', data: result['data']);
      } else {
        return PaymentResult.failure(result['message']);
      }
    } catch (e) {
      return PaymentResult.failure('Status check failed: ${e.toString()}');
    }
  }
}
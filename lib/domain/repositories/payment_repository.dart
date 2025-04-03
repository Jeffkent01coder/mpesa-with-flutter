import '../../domain/entities/payment.dart';

abstract class PaymentRepository {
  Future<PaymentResult> initiatePayment(Payment payment);
  Future<PaymentResult> checkPaymentStatus(String checkoutRequestId);
}

class PaymentResult {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  PaymentResult({
    required this.success,
    required this.message,
    this.data,
  });

  factory PaymentResult.success(String message, {Map<String, dynamic>? data}) {
    return PaymentResult(success: true, message: message, data: data);
  }

  factory PaymentResult.failure(String message) {
    return PaymentResult(success: false, message: message);
  }
}
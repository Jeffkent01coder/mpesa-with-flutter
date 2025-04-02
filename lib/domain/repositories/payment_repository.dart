import '../entities/payment.dart';

abstract class PaymentRepository {
  // Initiate a payment transaction
  Future<PaymentResult> initiatePayment(Payment payment);
}

// Result class to encapsulate the outcome of a payment operation
class PaymentResult {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  PaymentResult({
    required this.success,
    required this.message,
    this.data,
  });

  // Factory constructor for success case
  factory PaymentResult.success(String message, {Map<String, dynamic>? data}) {
    return PaymentResult(
      success: true,
      message: message,
      data: data,
    );
  }

  // Factory constructor for failure case
  factory PaymentResult.failure(String message) {
    return PaymentResult(
      success: false,
      message: message,
    );
  }
}
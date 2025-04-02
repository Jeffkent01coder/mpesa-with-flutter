import '../entities/payment.dart';
import '../repositories/payment_repository.dart';

class ProcessPaymentUseCase {
  final PaymentRepository repository;

  ProcessPaymentUseCase(this.repository);

  // Execute the use case with the given parameters
  Future<PaymentResult> execute({
    required String phoneNumber,
    required String amountString,
  }) async {
    // Validate input
    if (phoneNumber.isEmpty || amountString.isEmpty) {
      return PaymentResult.failure("Phone number and amount are required");
    }

    if (!phoneNumber.startsWith('254') || phoneNumber.length != 12) {
      return PaymentResult.failure("Please enter a valid phone number starting with 254");
    }

    double? amount = double.tryParse(amountString);
    if (amount == null || amount <= 0) {
      return PaymentResult.failure("Please enter a valid amount greater than 0");
    }

    // Create payment entity and process it through the repository
    final payment = Payment(
      phoneNumber: phoneNumber,
      amount: amount,
    );

    return await repository.initiatePayment(payment);
  }
}
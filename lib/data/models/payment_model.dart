import '../../domain/entities/payment.dart';

class PaymentModel extends Payment {
  PaymentModel({
    required String phoneNumber,
    required double amount,
    String businessCode = "174379",
    String reference = "Test Payment",
    String description = "Test Payment",
  }) : super(
          phoneNumber: phoneNumber,
          amount: amount,
          businessCode: businessCode,
          reference: reference,
          description: description,
        );

  // Convert model to map for API requests
  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'amount': amount,
      'businessShortCode': businessCode,
      'accountReference': reference,
      'transactionDesc': description,
    };
  }

  // Create model from map (e.g., from API responses)
  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      phoneNumber: map['phoneNumber'],
      amount: map['amount'],
      businessCode: map['businessShortCode'] ?? "174379",
      reference: map['accountReference'] ?? "Test Payment",
      description: map['transactionDesc'] ?? "Test Payment",
    );
  }

  // Create model from domain entity
  factory PaymentModel.fromEntity(Payment payment) {
    return PaymentModel(
      phoneNumber: payment.phoneNumber,
      amount: payment.amount,
      businessCode: payment.businessCode,
      reference: payment.reference,
      description: payment.description,
    );
  }
}
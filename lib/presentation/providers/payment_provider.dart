import 'package:flutter/material.dart';
import '../../domain/usecases/process_payment_usecase.dart';

class PaymentProvider extends ChangeNotifier {
  final ProcessPaymentUseCase _processPaymentUseCase;

  PaymentProvider(this._processPaymentUseCase);

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  // Reset state
  void resetState() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  // Process payment
  Future<bool> processPayment({
    required String phoneNumber,
    required String amount,
  }) async {
    resetState();

    _isLoading = true;
    notifyListeners();

    try {
      // Execute the use case
      final result = await _processPaymentUseCase.execute(
        phoneNumber: phoneNumber,
        amountString: amount,
      );

      _isLoading = false;

      if (result.success) {
        _successMessage = result.message;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result.message;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = "Unexpected error: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }
}
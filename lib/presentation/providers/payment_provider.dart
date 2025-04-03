import 'package:flutter/material.dart';
import '../../domain/usecases/process_payment_usecase.dart';

class PaymentProvider extends ChangeNotifier {
  final ProcessPaymentUseCase _processPaymentUseCase;

  PaymentProvider(this._processPaymentUseCase);

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  String? _transactionStatus;
  String? _checkoutRequestId;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  String? get transactionStatus => _transactionStatus;

  // Reset state
  void resetState() {
    _errorMessage = null;
    _successMessage = null;
    _transactionStatus = null;
    _checkoutRequestId = null;
    notifyListeners();
  }

  // Process payment with status checking
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

      if (result.success) {
        _checkoutRequestId = result.data?['CheckoutRequestID'];
        _successMessage = 'STK Push initiated. Please enter PIN on your phone.';
        
        // Start status checking
        await _checkTransactionStatus();
        return true;
      } else {
        _isLoading = false;
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

  // Check transaction status periodically
  Future<void> _checkTransactionStatus() async {
    if (_checkoutRequestId == null) return;

    const maxAttempts = 10;
    const delay = Duration(seconds: 3);
    int attempts = 0;

    while (attempts < maxAttempts) {
      try {
        final statusResult = await _processPaymentUseCase.checkStatus(_checkoutRequestId!);
        
        if (statusResult.success) {
          _transactionStatus = statusResult.data?['ResultCode'] == '0' ? 'Success' : 'Failed';
          _isLoading = false;
          
          if (_transactionStatus == 'Success') {
            _successMessage = 'Payment completed successfully!';
          } else {
            _errorMessage = statusResult.data?['ResultDesc'] ?? 'Payment failed';
          }
          notifyListeners();
          return;
        }
        
        attempts++;
        await Future.delayed(delay);
      } catch (e) {
        attempts++;
        if (attempts >= maxAttempts) {
          _isLoading = false;
          _errorMessage = 'Failed to verify transaction status';
          notifyListeners();
          return;
        }
        await Future.delayed(delay);
      }
    }
  }
}
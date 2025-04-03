import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mpesa_flutter_plugin/initializer.dart';
import '../models/payment_model.dart';

abstract class MpesaDataSource {
  Future<Map<String, dynamic>> initiateSTKPush(PaymentModel payment);
  Future<Map<String, dynamic>> queryTransactionStatus(String checkoutRequestId);
}

class MpesaDataSourceImpl implements MpesaDataSource {
  static const String _consumerKey = "Your Consumer Key";
  static const String _consumerSecret = "Your Consumer Secret Key";
  static const String _passKey = "Your pass Key";
  static const String _businessShortCode = "174379";
  static const String _accessTokenUrl = "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials";
  static const String _stkPushUrl = "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest";
  static const String _queryUrl = "https://sandbox.safaricom.co.ke/mpesa/stkpushquery/v1/query";

  String? _cachedAccessToken;

  void initialize() {
    MpesaFlutterPlugin.setConsumerKey(_consumerKey);
    MpesaFlutterPlugin.setConsumerSecret(_consumerSecret);
  }

  // Generate access token
  Future<String> _getAccessToken() async {
    if (_cachedAccessToken != null) return _cachedAccessToken!;

    final auth = base64Encode(utf8.encode('$_consumerKey:$_consumerSecret'));
    final response = await http.get(
      Uri.parse(_accessTokenUrl),
      headers: {
        'Authorization': 'Basic $auth',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _cachedAccessToken = data['access_token'];
      return _cachedAccessToken!;
    } else {
      throw Exception('Failed to get access token: ${response.body}');
    }
  }

  // Generate timestamp in YYYYMMDDHHMMSS format
  String _getTimestamp() {
    final date = DateTime.now();
    final year = date.year.toString();
    final month = (date.month).toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final hours = date.hour.toString().padLeft(2, '0');
    final minutes = date.minute.toString().padLeft(2, '0');
    final seconds = date.second.toString().padLeft(2, '0');
    return '$year$month$day$hours$minutes$seconds';
  }

  // Generate password
  String _generatePassword(String shortcode, String passkey, String timestamp) {
    final password = '$shortcode$passkey$timestamp';
    return base64Encode(utf8.encode(password));
  }

  @override
  Future<Map<String, dynamic>> initiateSTKPush(PaymentModel payment) async {
    try {
      final accessToken = await _getAccessToken();
      final timestamp = _getTimestamp();
      final password = _generatePassword(_businessShortCode, _passKey, timestamp);

      final response = await http.post(
        Uri.parse(_stkPushUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'BusinessShortCode': _businessShortCode,
          'Password': password,
          'Timestamp': timestamp,
          'TransactionType': 'CustomerPayBillOnline',
          'Amount': payment.amount,
          'PartyA': payment.phoneNumber,
          'PartyB': _businessShortCode,
          'PhoneNumber': payment.phoneNumber,
          'CallBackURL': 'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest',
          'AccountReference': payment.reference,
          'TransactionDesc': payment.description,
        }),
      );

      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        debugPrint("Transaction Result: $result");
        return {
          'success': true,
          'message': 'STK Push sent successfully',
          'data': result,
        };
      } else {
        return {
          'success': false,
          'message': result['errorMessage'] ?? 'Failed to initiate STK Push',
        };
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  @override
  Future<Map<String, dynamic>> queryTransactionStatus(String checkoutRequestId) async {
    try {
      final accessToken = await _getAccessToken();
      final timestamp = _getTimestamp();
      final password = _generatePassword(_businessShortCode, _passKey, timestamp);

      final response = await http.post(
        Uri.parse(_queryUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'BusinessShortCode': _businessShortCode,
          'Password': password,
          'Timestamp': timestamp,
          'CheckoutRequestID': checkoutRequestId,
        }),
      );

      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': result,
        };
      } else {
        return {
          'success': false,
          'message': result['errorMessage'] ?? 'Failed to query transaction status',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}
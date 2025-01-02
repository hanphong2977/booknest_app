import 'package:flutter/material.dart';

class PaymentProvider with ChangeNotifier {
  // Giả lập trạng thái thanh toán
  bool _isPaymentSuccessful = false;
  String _paymentMessage = '';

  bool get isPaymentSuccessful => _isPaymentSuccessful;
  String get paymentMessage => _paymentMessage;

  // Phương thức xử lý thanh toán giả
  Future<void> processPayment(String method, double amount) async {
    _paymentMessage = 'Processing $method payment...';

    // Giả lập quá trình thanh toán
    await Future.delayed(const Duration(seconds: 2), () {
      _paymentMessage = '$method payment of ₹$amount was successful!';
      _isPaymentSuccessful = true;
    });

    // Cập nhật UI
    notifyListeners();
  }

  // Hủy bỏ thanh toán giả
  void cancelPayment() {
    _isPaymentSuccessful = false;
    _paymentMessage = 'Payment cancelled.';
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booknest_app/provider/booking_provider.dart';
import 'package:booknest_app/provider/payment_provider.dart';
import 'package:booknest_app/view/payment_success_page.dart';

class PaymentCheckoutPage extends StatelessWidget {
  const PaymentCheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    final totalAmount = bookingProvider.calculateTotalAmount();
    final paymentProvider = Provider.of<PaymentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Payment Checkout'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '₹', // Rupee symbol
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  totalAmount.toStringAsFixed(2), // Show the formatted amount
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          // Thanh toán Google Pay
          ListTile(
            leading: Image.asset('assets/images/google_pay.png', width: 40),
            title: const Text('Google Pay'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              paymentProvider.processPayment('Google Pay', totalAmount);
              // Sau khi thanh toán thành công, chuyển trang tới PaymentSuccessPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingConfirmationPage(),
                ),
              );
            },
          ),
          // Thanh toán Visa
          ListTile(
            leading: Image.asset('assets/images/visa.png', width: 40),
            title: const Text('Visa'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              paymentProvider.processPayment('Visa', totalAmount);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingConfirmationPage(),
                ),
              );
            },
          ),
          // Thanh toán MasterCard
          ListTile(
            leading: Image.asset('assets/images/mastercard.png', width: 40),
            title: const Text('MasterCard'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              paymentProvider.processPayment('MasterCard', totalAmount);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingConfirmationPage(),
                ),
              );
            },
          ),
          // Thanh toán Credit/Debit Card
          ListTile(
            leading: const Icon(Icons.credit_card, size: 40),
            title: const Text('Credit/Debit Card'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              paymentProvider.processPayment('Credit/Debit Card', totalAmount);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingConfirmationPage(),
                ),
              );
            },
          ),
          // Thanh toán Paytm
          ListTile(
            leading: Image.asset('assets/images/paytm.png', width: 40),
            title: const Text('Paytm'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              paymentProvider.processPayment('Paytm', totalAmount);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingConfirmationPage(),
                ),
              );
            },
          ),
          // Hiển thị trạng thái thanh toán
          if (paymentProvider.paymentMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                paymentProvider.paymentMessage,
                style: TextStyle(
                  color: paymentProvider.isPaymentSuccessful ? Colors.green : Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

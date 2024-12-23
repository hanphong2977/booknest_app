import 'package:flutter/material.dart';


class PaymentCheckoutPage extends StatelessWidget {
  const PaymentCheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '₹', // Rupee symbol
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Image.asset('assets/images/google_pay.png', width: 40),
            title: const Text('Google Pay'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset('assets/images/visa.png', width: 40),
            title: const Text('Visa'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset('assets/images/mastercard.png', width: 40),
            title: const Text('MasterCard'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.credit_card, size: 40),
            title: const Text('Credit/Debit Card'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset('assets/images/paytm.png', width: 40),
            title: const Text('Paytm'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
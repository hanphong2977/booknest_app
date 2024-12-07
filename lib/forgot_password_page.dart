import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPage createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24),
            // Tiêu đề
            Text(
              'Forgot Your Password?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Enter your email to reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 24),
            // Trường nhập Email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Color(0xFF60A5FA)),
                ),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 24),
            // Nút Gửi yêu cầu đặt lại mật khẩu
            ElevatedButton(
              onPressed: () {
                // Xử lý logic gửi yêu cầu đặt lại mật khẩu tại đây
                print('Reset password email: ${_emailController.text}');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF60A5FA),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                'Send Reset Link',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
            // Dòng quay lại Login Page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Remember your password? '),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Quay lại trang Login Page
                  },
                  child: Text(
                    'Back to Login',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Hình ảnh minh họa
            Image.asset(
              'assets/images/forgot_password_page_img.png',
              height: 500,
            ),
          ],
        ),
      ),
    );
  }
}

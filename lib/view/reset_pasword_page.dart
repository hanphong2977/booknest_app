import 'package:booknest_app/provider/auth_provider.dart';
import 'package:booknest_app/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;

  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPage();
}

class _ResetPasswordPage extends State<ResetPasswordPage> {
  bool _isPasswordVisible = false;

  final TextEditingController _resetPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            // Tiêu đề
            const Text(
              'Enter Your New Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            // Trường nhập Email
            TextField(
              controller: _resetPasswordController,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), // Bo góc
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Color(0xFF60A5FA)),
                ),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible =
                          !_isPasswordVisible; // Thay đổi trạng thái
                    });
                  },
                ),
              ),
              obscureText:
                  !_isPasswordVisible, // Hiện/ẩn mật khẩu dựa vào trạng thái
            ),
            const SizedBox(height: 24),
            // Nút Gửi yêu cầu đặt lại mật khẩu
            ElevatedButton(
              onPressed: () async {
                // Lấy dữ liệu từ TextField hoặc các input khác nếu cần
                String newPassword = _resetPasswordController.text;

                // Kiểm tra nếu password không rỗng
                if (newPassword.isNotEmpty) {
                  // Gọi hàm updatePassword từ Provider
                  final success = await authProvider.updatePassword(widget.email, newPassword);

                  // Xử lý kết quả từ updatePassword
                  if (success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Password updated successfully")),
                    );
                    // Có thể điều hướng đến trang khác nếu cần
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Failed to update password")),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Please enter a new password")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF60A5FA),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text(
                'Reset Password',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            // Hình ảnh minh họa
            Image.asset(
              'assets/images/forgot_password_page_img.png',
              height: 550,
            ),
          ],
        ),
      ),
    );
  }
}

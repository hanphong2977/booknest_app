import 'dart:async';
import 'dart:math';
import 'package:booknest_app/database/db_helper.dart';
import 'package:booknest_app/models/guest.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = true;

  bool get isLoggedIn => _isLoggedIn;

  Guest? _currentUser;
  String? _jwtToken;

  Guest? get currentUser => _currentUser;

  bool get isAuthenticated => _currentUser != null;

  // biến tạm để lưu verification code
  Map<String, Map<String, dynamic>> verificationCodes = {};

  final DBHelper _dbHelper = DBHelper();

  // Đăng ký người dùng
  Future<bool> register(Guest guest) async {
    try {
      final existingGuest = await _dbHelper.findGuestByUsername(guest.userName);
      if (existingGuest != null) {
        // Tên người dùng đã tồn tại
        return false;
      }
      await _dbHelper.registerGuest(guest);
      final dbGuest = await _dbHelper.findGuestByUsername(guest.userName);
      await _dbHelper.assignRoleToGuest(dbGuest?.id!, 'guest');
      return true;
    } catch (e) {
      print("Error during registration: $e");
      return false;
    }
  }

  // Đăng nhập người dùng
  Future<bool> login(String username, String password) async {
    try {
      final guest =
          await _dbHelper.findGuestByUsernameAndPassword(username, password);
      if (guest != null) {
        // final isAdmin = await _dbHelper.checkGuestRole(guest.id!, 'admin');
        final isUser = await _dbHelper.checkGuestRole(guest.id!, 'guest');
        if (isUser) {
          // Tạo JWT token (giả lập)
          _jwtToken = "fake.jwt.token";
          _currentUser = guest;
          _isLoggedIn = true;
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      print("Error during login: $e");
      return false;
    }
  }

  // Đăng xuất người dùng
  void logout() {
    _isLoggedIn = false;
    _currentUser = null;
    _jwtToken = null;
    notifyListeners();
  }

  // Phương thức tạo mã xác minh ngẫu nhiên
  String _generateVerificationCode() {
    final random = Random();
    return (random.nextInt(9000) + 1000)
        .toString(); // Tạo số ngẫu nhiên 4 chữ số
  }

  // Quên mật khẩu (giả lập gửi email khôi phục)
  Future<bool> resetPassword(String email) async {
    try {
      // Kiểm tra email trong cơ sở dữ liệu
      final guest = await _dbHelper.findGuestByEmail(email);
      if (guest != null) {
        // Tạo mã xác minh ngẫu nhiên
        String verificationCode = _generateVerificationCode();

        // Lưu mã xác minh và thời gian hết hạn (5 phút)
        verificationCodes[email] = {
          'code': verificationCode,
          'expiresAt': DateTime.now().add(const Duration(minutes: 5)),
        };

        // Cấu hình thông tin SMTP MailTrap
        final smtpServer = SmtpServer(
          'sandbox.smtp.mailtrap.io',
          port: 587,
          username: 'e9cb1390ecfd3a',
          password: '42baabdaf79aea',
          ignoreBadCertificate: true,
        );

        // Tạo email
        final message = Message()
          ..from = const Address('chibao04112003@gmail.com', 'BookNest Hotel')
          ..recipients.add(email)
          ..subject = 'Password Reset Request'
          ..text = 'Your verification code is: $verificationCode\n\n'
              'This code will expire in 5 minutes.';
        try {
          // Gửi email qua SMTP MailTrap
          final sendReport = await send(message, smtpServer);
          print('Message sent: ' + sendReport.toString());
          return true;
        } catch (e) {
          print('Error sending email: $e');
          return false;
        }
      }
      return false;
    } catch (e) {
      print("Error during password reset: $e");
      return false;
    }
  }

  // Phương thức kiểm tra mã xác minh người dùng nhập
  bool verifyCode(String email, String enteredCode) {
    final verificationData = verificationCodes[email];

    if (verificationData != null) {
      final savedCode = verificationData['code'];
      final expiresAt = verificationData['expiresAt'];

      if (DateTime.now().isBefore(expiresAt)) {
        // Nếu mã còn hợp lệ (chưa hết hạn), kiểm tra mã người dùng nhập
        if (savedCode == enteredCode) {
          return true; // Mã hợp lệ
        }
      }
    }
    return false; // Mã không hợp lệ hoặc hết hạn
  }

  // Thêm phương thức cập nhật mật khẩu
  Future<bool> updatePassword(String email, String newPassword) async {
    try {
      final guest = await _dbHelper.findGuestByEmail(email);
      if (guest != null) {
        // Cập nhật mật khẩu mới cho người dùng trong cơ sở dữ liệu
        guest.password = newPassword;

        // Cập nhật vào cơ sở dữ liệu
        await _dbHelper.updateGuest(guest);

        print("Password updated successfully for $email.");
        return true;
      }
      return false;
    } catch (e) {
      print("Error updating password: $e");
      return false;
    }
  }
}

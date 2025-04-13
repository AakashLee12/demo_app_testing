import 'package:demo_app_testing/model/user_details.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  List<UserDetails> users = [
    UserDetails(
      userId: 'A1',
      name: "Aakash",
      mobileNo: '8812345678',
      password: 'A@kash12',
      email: 'aakash@gmail.com',
    ),
    UserDetails(
      userId: 'A2',
      name: "GOKUL",
      mobileNo: '8812345678',
      password: 'Gokul@13',
      email: 'gokul1@gmail.com',
    ),
    UserDetails(
      userId: 'A3',
      name: "GokulaKrishna",
      mobileNo: '8812345678',
      password: 'Gokul@12',
      email: 'gokul2@gmail.com',
    ),
  ];

  // Controllers for the form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Controllers for new pages
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController demoEmailController = TextEditingController();

  // Error message for failed login
  String? loginError;

  int otpAttempts = 0; // To track OTP attempts

  void setLogingError(String? value) {
    loginError = value;
    notifyListeners();
  }

  String _demoEmail = '';
  String demoEmail() => _demoEmail;
  setDemoEmail(String value) {
    _demoEmail = value;
    notifyListeners();
  }

  void setNotify() {
    notifyListeners();
  }

  // Add a new user
  void addUser(String name, String phone, String email, String password) {
    final userId = 'A${users.length + 1}'; // Generate a new userId
    final newUser = UserDetails(
      userId: userId,
      name: name,
      mobileNo: phone,
      password: password,
      email: email,
    );

    users.add(newUser);
    notifyListeners();
  }

  // Method to authenticate the user
  bool authenticateUser(String email, String password) {
    final user = users.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse:
          () => UserDetails(
            userId: '',
            name: '',
            mobileNo: '',
            password: '',
            email: '',
          ),
    );

    return user.userId.isNotEmpty;
  }

  // Check if the email exists
  bool isEmailRegistered(String value) {
    try {
      debugPrint('${value == users[0].email}');
      final user = users.firstWhere(
        (user) => user.email.toLowerCase() == value.toLowerCase(),
      );
      return true; // Email found
    } catch (e) {
      return false; // No matching email found
    }
  }

  // Simulate OTP verification process (static OTP)
  bool verifyOTP(String otp) {
    if (otp == "1234") {
      otpAttempts = 0; // Reset attempts after successful OTP
      return true;
    } else {
      otpAttempts++;
      if (otpAttempts >= 3) {
        otpAttempts = 0; // Reset attempts after 3 failed tries
        return false;
      }
      return false;
    }
  }

  // Method to update the password for the user
  void updatePassword(String email, String newPassword) {
    final userIndex = users.indexWhere((user) => user.email == email);
    if (userIndex != -1) {
      // Create a new UserDetails object with updated password using copyWith
      users[userIndex] = users[userIndex].copyWith(password: newPassword);
      notifyListeners();
    }
  }

  // Clear the controllers
  void clearControllers() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    otpController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

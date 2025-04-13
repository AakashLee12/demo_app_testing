import 'package:demo_app_testing/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'password_update_page.dart';

class OTPVerificationPage extends StatelessWidget {
  final String email;
  OTPVerificationPage(this.email);

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(
      context,
      listen: false,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("OTP Verification")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Enter the OTP sent to your email"),
              SizedBox(height: 20),
              TextField(
                controller: loginController.otpController,
                decoration: InputDecoration(labelText: "OTP"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (loginController.otpController.text == "1234") {
                    loginController.clearControllers();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PasswordUpdatePage(email),
                      ),
                    );
                  } else {
                    loginController.otpAttempts++;
                    if (loginController.otpAttempts >= 3) {
                      loginController.clearControllers();
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Incorrect OTP")));
                  }
                },
                child: Text("Verify OTP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

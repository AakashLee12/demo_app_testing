import 'package:demo_app_testing/controller/login_controller.dart';
import 'package:demo_app_testing/view/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_app_testing/common_widgets/common_text_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(
      context,
      listen: false,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Forgot Password"),
          leading: InkWell(
            onTap: () {
              loginController.emailController.clear();
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_sharp),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Use CommonTextField here instead of TextFormField
              CommonTextField(
                label: "Enter your email",
                controller: loginController.emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }

                  // Email validation regex (only allows alphanumeric, @, and .)
                  final emailRegex = RegExp(
                    r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$',
                  );

                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid emailId';
                  }

                  return null;
                },
                onChanged: (value) {},
                onTap: () {
                  // You can handle any onTap action here
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String email = loginController.emailController.text.trim();
                  if (loginController.isEmailRegistered(email)) {
                    // Proceed to OTP Verification Page if email is registered
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OTPVerificationPage(email),
                      ),
                    );
                  } else {
                    // Show message if email is not registered
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Email not registered")),
                    );
                  }
                },
                child: Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

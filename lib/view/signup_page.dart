import 'package:demo_app_testing/common_widgets/common_text_field.dart';
import 'package:demo_app_testing/controller/login_controller.dart';
import 'package:demo_app_testing/view/home/my_home_page.dart';
import 'package:demo_app_testing/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signUpController = Provider.of<LoginController>(
      context,
      listen: false,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Sign Up Page')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Name Field
                CommonTextField(
                  label: 'Name',
                  controller: signUpController.nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),

                // Phone Number Field
                CommonTextField(
                  label: 'Phone Number',
                  controller: signUpController.phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    final phoneRegex = RegExp(
                      r'^\d{10}$',
                    ); // Validates 10 digits.
                    if (!phoneRegex.hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),

                // Email Field
                CommonTextField(
                  label: 'Email',
                  controller: signUpController.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }

                    // Email validation regex
                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$',
                    );

                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }

                    // Check if email already exists
                    final userExists = signUpController.users.any(
                      (user) => user.email == value,
                    );
                    if (userExists) {
                      return 'Email is already taken';
                    }

                    return null;
                  },
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),

                // Password Field
                CommonTextField(
                  label: 'Password',
                  isPassword: true,
                  controller: signUpController.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    // Password validation regex (at least one uppercase letter, one number, and one special character)
                    final passwordRegex = RegExp(
                      r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{6,}$',
                    );

                    if (!passwordRegex.hasMatch(value)) {
                      return 'Password must contain at least one uppercase letter, one number, and one special character';
                    }

                    return null;
                  },
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final name = signUpController.nameController.text.trim();
                      final phone =
                          signUpController.phoneController.text.trim();
                      final email =
                          signUpController.emailController.text.trim();
                      final password =
                          signUpController.passwordController.text.trim();

                      // Add the new user
                      signUpController.addUser(name, phone, email, password);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sign-Up Successful')),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(email),
                        ),
                      );
                      signUpController.clearControllers();
                    }
                  },
                  child: Text('Submit'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "I already have an account",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "LogIn",
                          style: TextStyle(
                            decoration:
                                TextDecoration.underline, // Add underline here
                            color:
                                Colors
                                    .blue, // Optional: You can also set the text color to blue to make it look like a link
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

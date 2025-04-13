import 'package:demo_app_testing/common_widgets/common_text_field.dart';
import 'package:demo_app_testing/controller/login_controller.dart';
import 'package:demo_app_testing/view/forget_password_page.dart';
import 'package:demo_app_testing/view/home/my_home_page.dart';
import 'package:demo_app_testing/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Using listen: false to avoid rebuilding the widget on state changes
    final loginController = Provider.of<LoginController>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonTextField(
                  label: 'Email',
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

                    // If there's a login error, show it here
                    if (loginController.loginError != null) {
                      return loginController
                          .loginError; // Show error from LoginController
                    }
                    loginController.setLogingError(null);

                    return null;
                  },
                  onChanged: (value) {},

                  onTap: () {
                    loginController.setLogingError(null);
                  },
                ),
                SizedBox(height: 20),
                CommonTextField(
                  label: 'Password',
                  isPassword: true,
                  controller: loginController.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    // Password validation regex (at least one letter, one number, and 6 characters)
                    final passwordRegex = RegExp(
                      r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{6,}$',
                    );

                    if (!passwordRegex.hasMatch(value)) {
                      return 'Invalid Password';
                    }

                    // If there's a login error, show it here
                    if (loginController.loginError != null) {
                      return loginController
                          .loginError; // Show error from LoginController
                    }

                    return null;
                  },
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final email = loginController.emailController.text.trim();
                      final password =
                          loginController.passwordController.text.trim();

                      // Now perform authentication when the submit button is pressed
                      bool isAuthenticated = loginController.authenticateUser(
                        email,
                        password,
                      );

                      if (isAuthenticated) {
                        // Authentication successful
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login Successful')),
                        );
                        // Navigate to Home Page after successful login
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(email),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('Login Failed')));
                      }
                    }
                  },
                  child: Text('Submit'),
                ),
                SizedBox(height: 20),
                // Forgot password link
                TextButton(
                  onPressed: () {
                    // Navigate to Forgot Password page
                    loginController.emailController.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "I don't have an account?",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          loginController.clearControllers();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          "SignUp",
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
                Expanded(
                  child: ListView.builder(
                    itemCount: loginController.users.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text('User ${index + 1}:'),
                          Text(loginController.users[index].name),
                        ],
                      );
                    },
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

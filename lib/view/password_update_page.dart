import 'package:demo_app_testing/controller/login_controller.dart';
import 'package:demo_app_testing/view/home/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordUpdatePage extends StatelessWidget {
  final String email;
  PasswordUpdatePage(this.email);

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(
      context,
      listen: false,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Update Password")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: loginController.newPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "New Password"),
              ),
              TextFormField(
                controller: loginController.confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Confirm Password"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (loginController.newPasswordController.text ==
                      loginController.confirmPasswordController.text) {
                    // loginController.updatePassword(
                    //   email,
                    //   loginController.newPasswordController.text,
                    // );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password updated successfully")),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(email)),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Passwords do not match")),
                    );
                  }
                },
                child: Text("Update Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

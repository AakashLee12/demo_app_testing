import 'package:demo_app_testing/controller/login_controller.dart';
import 'package:demo_app_testing/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String email;
  HomePage(this.email);

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    final user = loginController.users.firstWhere(
      (user) => user.email == email,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          leading: InkWell(
            onTap: () {
              loginController.clearControllers();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Icon(Icons.arrow_back_ios_new_sharp),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              "Welcome, ${user.name}",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}

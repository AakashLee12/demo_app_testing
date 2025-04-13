import 'package:demo_app_testing/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DemoLogin extends StatelessWidget {
  const DemoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(title: Text('DemoLogin')),
      drawer: Container(
        width: MediaQuery.sizeOf(context).width * 0.5,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(children: [Text('Gokul')]),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Hi Gokul')),
          Text('Email'),
          TextFormField(
            controller: loginController.demoEmailController,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            style: TextStyle(),
          ),
          ElevatedButton(
            onPressed: () {
              loginController.setDemoEmail(
                loginController.demoEmailController.text,
              );
            },
            child: Text('Submit'),
          ),
          Consumer<LoginController>(
            builder: (context, loginController, child) {
              return Text(
                loginController.demoEmailController.text,
              ); // This will update when demoEmail changes
            },
          ),
        ],
      ),
    );
  }
}

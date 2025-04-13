import 'package:demo_app_testing/controller/login_controller.dart';
import 'package:demo_app_testing/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue, // Set AppBar color to blue
          titleTextStyle: TextStyle(color: Colors.white),
          // Ensure the title is white,
        ),
      ),
      home: SafeArea(
        child: LoginPage(), // SafeArea wraps the LoginPage to ensure safe UI.
      ),
    );
  }
}

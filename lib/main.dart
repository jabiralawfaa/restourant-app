import 'package:restaurant_app/register.dart';
import 'package:restaurant_app/login.dart';
import 'package:restaurant_app/lupa_password.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(), 
        '/register': (context) => RegisterPage(), 
        '/lupa_password': (context) => ForgotPasswordPage(), 
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'feature/auth/domain/di/auth_injection.dart';
import 'feature/cart/domain/di/cart_injection.dart';
import 'splash_wrapper.dart';

void main() {
  // Init DI
  initAuthInjection();
  initCartInjection();
  runApp(const BadmintonApp());
}

class BadmintonApp extends StatelessWidget {
  const BadmintonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Badminton App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashWrapper(),
    );
  }
}

import 'package:flutter/material.dart';
import 'feature/login/domain/di/login_injection.dart';
import 'splash_wrapper.dart';

void main() {
  // Init DI
  initLoginFeature();
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

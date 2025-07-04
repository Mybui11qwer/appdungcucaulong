import 'package:flutter/material.dart';
import 'feature/login/domain/di/login_injection.dart';
import 'feature/login/presentation/page/login_page.dart';

void main() {
  // Khởi tạo dependency injection cho module login
  initLoginFeature();
  runApp(const BadmintonLoginApp());
}

class BadmintonLoginApp extends StatelessWidget {
  const BadmintonLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Badminton App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

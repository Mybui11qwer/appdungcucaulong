import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/auth/domain/di/auth_injection.dart';
import 'feature/cart/domain/di/cart_injection.dart';
import 'feature/cart/presentation/bloc/cart_bloc.dart';
import 'splash_wrapper.dart';

void main() {
  // Init DI
  initAuthInjection();
  initCartInjection();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CartBloc>()),
      ],
      child: const BadmintonApp(),
    ),
  );
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

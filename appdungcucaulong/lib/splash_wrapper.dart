import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'feature/auth/presentation/page/intro_page.dart';
import 'feature/auth/presentation/page/login_page.dart';
import 'feature/product/presentation/bloc/product_bloc.dart';
import 'feature/product/presentation/page/index.dart';
import 'feature/product/domain/di/product_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/product/presentation/bloc/product_event.dart';

class SplashWrapper extends StatelessWidget {
  const SplashWrapper({super.key});

  Future<(bool seenIntro, bool isLoggedIn, int? customerId)> getInitStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final seenIntro = prefs.getBool('hasSeenIntro') ?? false;
    final token = prefs.getString('accessToken');
    final customerId = prefs.getInt('customerId');
    return (seenIntro, token != null, customerId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<(bool, bool, int?)>(
      future: getInitStatus(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final (seenIntro, loggedIn, customerId) = snapshot.data!;
        if (!seenIntro) {
          return const Intro(); // hiện màn hình Intro
        } else if (loggedIn && customerId != null) {
          return BlocProvider<ProductBloc>(
            create: (_) => getIt<ProductBloc>()..add(LoadProductsEvent()),
            child: IndexPage(),
          );
        } else {
          return LoginPage(); // chưa login
        }
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'feature/login/presentation/page/login_page.dart';
import 'feature/product/presentation/page/product_page.dart';
import 'feature/product/domain/di/product_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/product/presentation/bloc/product_event.dart';

class SplashWrapper extends StatelessWidget {
  const SplashWrapper({super.key});

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('accessToken');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.data == true) {
          return BlocProvider(
            create: (_) => injectProductBloc()..add(LoadProductsEvent()),
            child: const ProductPage(),
          );
        } else {
          return LoginPage();
        }
      },
    );
  }
}

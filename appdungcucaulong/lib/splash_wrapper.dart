import 'package:appdungcucaulong/screen/intro-screen/index.dart';
import 'package:appdungcucaulong/screen/profile-screen/index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'feature/auth/presentation/page/login_page.dart';
import 'feature/product/presentation/page/product_page.dart';
import 'feature/product/domain/di/product_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/product/presentation/bloc/product_event.dart';

class SplashWrapper extends StatelessWidget {
  const SplashWrapper({super.key});

  Future<(bool isLoggedIn, int? customerId)> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    final customerId = prefs.getInt('customerId');
    return (token != null, customerId);
  }

  @override
  Widget build(BuildContext context) {
    //Phần login
    //     return FutureBuilder<(bool, int?)>(
    //       future: getLoginStatus(),
    //       builder: (context, snapshot) {
    //         if (!snapshot.hasData) {
    //           return const Scaffold(
    //             body: Center(child: CircularProgressIndicator()),
    //           );
    //         }

    //       final (loggedIn, customerId) = snapshot.data!;
    //       if (loggedIn && customerId != null) {
    //         return BlocProvider(
    //           create: (_) => injectProductBloc()..add(LoadProductsEvent()),
    //           child: ProductPage(customerId: customerId, productId: 0),
    //         );
    //       } else {
    //         return LoginPage();
    //       }
    //     },
    //   );
    // }
    return (ProfileScreen());
  }
}

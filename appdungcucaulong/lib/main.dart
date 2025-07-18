import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/auth/domain/di/auth_injection.dart';
import 'feature/cart/domain/di/cart_injection.dart' as cart_di;
import 'feature/cart/presentation/bloc/cart_bloc.dart';
//import 'feature/product/presentation/page/index.dart';
import 'feature/order/domain/di/order_injection.dart';
import 'feature/product/domain/di/product_injection.dart' as product_di;
import 'feature/product/presentation/bloc/product_bloc.dart';
import 'feature/product/presentation/bloc/product_event.dart';
import 'feature/profile/domain/di/profile_injection.dart';
import 'splash_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo các DI
  initProfileModule();
  initAuthInjection();
  cart_di.initCartInjection();
  product_di.initProductInjection();
  initOrderModule();

  runApp(const BadmintonApp());
}

class BadmintonApp extends StatelessWidget {
  const BadmintonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => cart_di.getIt<CartBloc>()),
        BlocProvider(
          create: (_) => product_di.getIt<ProductBloc>()..add(LoadProductsEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Badminton App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashWrapper(),
      ),
    );
  }
}


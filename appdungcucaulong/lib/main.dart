import 'package:appdungcucaulong/feature/notifications/presentation/page/notification_page.dart';
import 'package:appdungcucaulong/feature/product/presentation/page/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
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
    //Đặt chế độ hiển thị là dọc
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    //Ẩn đi các thanh trạng thái và thanh điều hướng
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    
    return GetMaterialApp(
      title: 'Badminton App',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity // tự động căn chỉnh hiển thị tối ưu cho từng thiết bị
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => SplashWrapper(),
        '/notification': (context) => NotificationPage(),
        '/product': (context) => ShopPage(),
      },
      home: const SplashWrapper(),
    );
  }
}

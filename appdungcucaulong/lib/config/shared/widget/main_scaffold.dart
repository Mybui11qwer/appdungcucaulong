import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../../feature/profile/presentation/page/profile_page.dart';
import '../../../feature/product/presentation/page/index.dart';
import '../../../feature/product/presentation/page/product_page.dart';

class MainScaffold extends StatefulWidget {
  final Widget body;
  final int currentIndex;

  const MainScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _navigateWithFade(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }

  void _onTap(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        _navigateWithFade(context, const IndexPage());
        break;
      case 1:
        _navigateWithFade(context, const IndexPage());
        break;
      case 2:
        _navigateWithFade(context, const IndexPage());
        break;
      case 3:
        _navigateWithFade(context, const ProductPage());
        break;
      case 4:
        _navigateWithFade(context, const UserProfilePage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.transparent,
        color: const Color(0xFF0D47A1),
        buttonBackgroundColor: Colors.blueAccent,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.notifications, color: Colors.white),
          Icon(Icons.bookmark, color: Colors.white),
          Icon(Icons.apps, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
        onTap: _onTap,
      ),
    );
  }
}

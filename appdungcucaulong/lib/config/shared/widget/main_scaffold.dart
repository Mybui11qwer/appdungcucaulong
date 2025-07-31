import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../../feature/favorite/presentation/page/favorites_page.dart';
import '../../../feature/notification/presentation/page/notifications_page.dart';
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

  void _onTap(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    Widget page;
    switch (index) {
      case 0:
        page = const IndexPage();
        break;
      case 1:
        page = const NotificationsPage();
        break;
      case 2:
        page = const FavoritesPage();
        break;
      case 3:
        page = const ProductPage();
        break;
      case 4:
        page = const UserProfilePage();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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

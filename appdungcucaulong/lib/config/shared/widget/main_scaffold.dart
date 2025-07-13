import 'package:appdungcucaulong/config/shared/widget/sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

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

    // Điều hướng
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/notification');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/favorites');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/product');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarWidget(),
      body: widget.body,
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: const Color(0xFF0D47A1),
        activeColor: Colors.white,
        color: Colors.blue,
        initialActiveIndex: _selectedIndex,
        style: TabStyle.react,
        onTap: _onTap,
        items: const [
          TabItem(icon: Icons.home),
          TabItem(icon: Icons.notifications),
          TabItem(icon: Icons.bookmark),
          TabItem(icon: Icons.apps),
          TabItem(icon: Icons.person),
        ],
      ),
    );
  }
}



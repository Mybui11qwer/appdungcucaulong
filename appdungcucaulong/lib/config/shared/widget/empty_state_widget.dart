import 'package:appdungcucaulong/config/shared/widget/main_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../feature/cart/presentation/widget/cart_top_sheet.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color iconColor;
  final Color backgroundColor;
  final int currentIndex;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.message,
    this.iconColor = Colors.grey,
    this.backgroundColor = Colors.white,
    required this.currentIndex, 
  });

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: currentIndex,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFF0047AB),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Icon(icon, size: 100, color: iconColor),
              const SizedBox(height: 16),
              Text(
                message,
                style: TextStyle(
                  fontSize: 18,
                  color: iconColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.shopping_cart, color: Color(0xFF0047AB)),
                onPressed: () {
                  showCartTopSheet(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

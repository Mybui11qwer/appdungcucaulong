import 'package:flutter/material.dart';

import '../../../../config/shared/widget/empty_state_widget.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      icon: Icons.favorite_border,
      message: "No favorites",
      backgroundColor: Colors.lightBlueAccent,
      iconColor: Colors.blue,
      currentIndex: 2,
    );
  }
}

import 'package:flutter/material.dart';

class ParallelWidget extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;
  final CrossAxisAlignment? crossAxisAlignment;

  const ParallelWidget({super.key, required this.widget1, required this.widget2, this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisAlignment:  MainAxisAlignment.spaceBetween,
      children: [
        widget1,
        widget2,
      ],
    );
  }
}

import 'package:appdungcucaulong/class/intro.dart';
import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:flutter/material.dart';

List<CategoryModel> categories = [
  CategoryModel(imgSrc: '', title: 'clothes'),
  CategoryModel(imgSrc: '', title: 'clothes'),
];

class CatergoriesSection extends StatelessWidget {
  const CatergoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomTitle(text: 'Categories'),
            CustomTitle(text: 'See all'),
          ],
        ),
        SafeArea(
          child: Row(
            children:[ 
              ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) => (
                  Container()
                ),
            ),]
          )
        ),
      ],
    );
  }
}

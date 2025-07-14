import 'package:flutter/material.dart';
import 'package:appdungcucaulong/class/intro.dart';
import 'package:appdungcucaulong/components/clipath-img/index.dart';
import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:appdungcucaulong/components/parralel-text/index.dart';

List<CategoryModel> categories = [
  CategoryModel(imgSrc: 'assets/images/clothess.jpg', title: 'clothes'),
  CategoryModel(imgSrc: 'assets/images/sneaker.jpg', title: 'sneaker'),
  CategoryModel(imgSrc: 'assets/images/sneaker.jpg', title: 'shutter'),
  CategoryModel(imgSrc: 'assets/images/badminton.jpg', title: 'racket'),
  CategoryModel(imgSrc:'assets/images/wrist.jpg' , title: 'bands')
];

class CatergoriesSection extends StatelessWidget {
  const CatergoriesSection({super.key});
  
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth- 20,
      padding: EdgeInsets.fromLTRB(0,30,0,0),
      child: Column(
        children: [
          SizedBox(height: 15,),
          ParrallelText(text1: 'Categories', text2: 'View All'),
          SizedBox(height: 15,),
          SizedBox(
            height: 90, // hoặc bất kỳ chiều cao nào bạn mong muốn
            child: ListView.builder(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipCircleImg(imgPath: categories[index].imgSrc, size: 50,),
                      SizedBox(height: 5,),
                      CustomTitle(text: categories[index].title, txtSize: 12,),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

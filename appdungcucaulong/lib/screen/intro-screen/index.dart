import 'package:appdungcucaulong/class/intro.dart';
import 'package:appdungcucaulong/components/custom-elevated-btn/index.dart';
import 'package:appdungcucaulong/components/intro-card/index.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

List<IntroModel> introScreens = [
  IntroModel(
    imgSrc: 'assets/intro_img/intro1.png',
    title: 'Search for gears',
    subTitle:
        'Find the right badminton gear for you. Search by product name, brand, or type.',
  ),
  IntroModel(
    imgSrc: 'assets/intro_img/intro2.png',
    title: 'Explore Badminton',
    subTitle:
        'Gear up for your best game with top-quality badminton equipment.',
  ),
  IntroModel(
    imgSrc: 'assets/intro_img/intro3.png',
    title: 'Play with Friends',
    subTitle: 'Play with friends and enjoy epic badminton matches together.',
  ),
];

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double radius = 240; // Bán kính hình tròn

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top:
                (-radius / 2 - 40) *
                2, // Đẩy hình tròn ra ngoài một chút ở phía trên
            left:
                screenWidth -
                radius -
                80 -
                (radius / 2), // Đặt hình tròn ở giữa
            child: Container(
              width: radius * 2, // Đặt chiều rộng của hình tròn
              height: radius * 2, // Đặt chiều cao của hình tròn
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue, // Màu của hình tròn
              ),
            ),
          ),
          Positioned(
            top: 200,
            child: Column(
              children: [
                // Phần nội dung thay đổi khi chọn tab
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: screenWidth,
                  height: _currentIndex==2 ? screenHeight - 170 : screenHeight - 220 , // Đặt chiều cao của phần nội dung
                  child: Swiper(
                    itemCount: introScreens.length,
                    pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.black38,
                        activeColor: Colors.blueAccent,
                      ),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return index == 2
                          ? IntroCard(
                            title: introScreens[index].title,
                            imgSrc: introScreens[index].imgSrc,
                            subTitle: introScreens[index].subTitle,
                            button: SizedBox(
                              width: double.infinity,
                              child: CustomelElevatebutton(
                                text: 'Lets go',
                                color: Colors.blue,
                                textColor: Colors.white,
                                onPressed: () => {},
                              ),
                            ),
                          )
                          : IntroCard(
                            imgSrc: introScreens[index].imgSrc,
                            title: introScreens[index].title,
                            subTitle: introScreens[index].subTitle,
                          );
                    },
                    onIndexChanged: (index)=>{
                      setState(() {
                        _currentIndex = index;
                      })
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

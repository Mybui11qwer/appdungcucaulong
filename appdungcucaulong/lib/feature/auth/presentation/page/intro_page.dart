import 'package:appdungcucaulong/class/intro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appdungcucaulong/config/components/custom-elevated-btn/index.dart';
import 'package:appdungcucaulong/config/components/custom-position-circle/index.dart';
import 'package:appdungcucaulong/config/components/intro-card/intro.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:appdungcucaulong/feature/auth/presentation/page/login_page.dart';

List<IntroModel> introScreens = [
  IntroModel(
    imgSrc: 'assets/introImages/intro1.png',
    title: 'Search for gears',
    subTitle:
        'Find the right badminton gear for you. Search by product name, brand, or type.',
  ),
  IntroModel(
    imgSrc: 'assets/introImages/intro2.png',
    title: 'Explore Badminton',
    subTitle:
        'Gear up for your best game with top-quality badminton equipment.',
  ),
  IntroModel(
    imgSrc: 'assets/introImages/intro3.png',
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

  Future<void> _completeIntro() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenIntro', true);
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double radius = 240; // Bán kính hình tròn
    return Scaffold(
      body: Stack(
        children: [
          CustomPositionCircle(
            moveTop: 80, 
            moveLeft: 40, 
            radius: radius, 
            screenWidth: screenWidth, 
            screenHeight: screenHeight),
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
                                onPressed: _completeIntro,
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
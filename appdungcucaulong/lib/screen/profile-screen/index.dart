import 'package:appdungcucaulong/components/custom-single-sroll/index.dart';
import 'package:appdungcucaulong/section/profile-screens-section/info-section/index.dart';
import 'package:flutter/material.dart';
import 'package:appdungcucaulong/components/custom-position-circle/index.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double radius = 50;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Stack(
              children: [
                Positioned(
                  top: 120,
                  left: 0,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight,
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 245, 240, 240),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50,),
                        InfoSection(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.shopping_bag, color: Colors.blueAccent,),
                  )
                ),
                Positioned(
                  top: 80,
                  left: 30,
                  child: Container(
                    width: 80,
                    height: 80,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(50)
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

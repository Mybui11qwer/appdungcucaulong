import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:flutter/material.dart';

class IntroCard extends StatelessWidget {
  final String title;
  final String imgSrc;
  final Widget? button;
  final String subTitle;

  const IntroCard({
    super.key,
    this.button,
    required this.title,
    required this.imgSrc,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          spacing: 5,
          children: [
            Image.asset(imgSrc),
            //title nè
            CustomTitle(
              text: title, 
              txtSize: 32,
              color: Colors.blue, 
              fontWeight: FontWeight.w600,),
            SizedBox(
              width: 350,
              //subtitle nè
              child: CustomTitle(
                txtSize: 16,
                text: subTitle, 
                color: Colors.black38,
                textAlign: TextAlign.center ,),
            ),
            //Nếu có thêm button truyền vô thì render nó ra 
            SizedBox(height: 190),
            if (button != null) button!,
          ],
        ),
      ),
    );
  }
}

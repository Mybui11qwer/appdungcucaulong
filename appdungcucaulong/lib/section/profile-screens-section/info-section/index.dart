import 'package:appdungcucaulong/components/custom-sliver-grid/index.dart';
import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:appdungcucaulong/components/profile-info-card/index.dart';
import 'package:appdungcucaulong/const/styled.dart';
import 'package:flutter/material.dart';

class InfoSection extends StatefulWidget {
  const InfoSection({super.key});

  @override
  State<InfoSection> createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitle(text: 'Phạm Đình Liêm', textStyle:  TextStyled.h5,),
          CustomTitle(text: 'liemp966@gmail.com', textStyle: TextStyled.p4,),
          SizedBox(height: 40,),
          Container(
            width: screenWidth,
            height: 320,
            child: CustomSilverGrid(
              quantity: 4,
              gridHeight: 100,
              aspectRatio: 1.44,
              itemBuilder: ((context,index)=>ProfileInfoCard()))
          ),
        ],
      ),
    );
  }
}
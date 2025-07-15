import 'package:appdungcucaulong/class/index.dart';
import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:flutter/material.dart';

List<SortingOption> sortOptionsList = [
  SortingOption(optIcon: Icons.new_releases, option: 'Latest'),
  SortingOption(optIcon: Icons.sell, option: 'Best'),
  SortingOption(optIcon: Icons.arrow_upward_rounded, option: 'Highest'),
  SortingOption(optIcon: Icons.arrow_downward, option: 'Lowest'),
];

class AllCategoryProductSection extends StatefulWidget {
  const AllCategoryProductSection({super.key,});
  

  @override
  State<AllCategoryProductSection> createState() =>
      _AllCategoryProductSectionState();
}

class _AllCategoryProductSectionState extends State<AllCategoryProductSection> {
  int onSortOpt = 0;
  
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        //Phần để filter
        Container(
          height: 60,
          width: screenWidth,
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.only(left: 10),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: sortOptionsList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        Positioned(child: Container()),
                        Center(
                          child: Row(
                            children: [
                              Icon(sortOptionsList[index].optIcon),
                              SizedBox(width: 10),
                              CustomTitle(text: sortOptionsList[index].option, txtSize: 14),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 20), // Khoảng cách giữa các item
              ),
          ),
          ),
      ],
    );
  }
}

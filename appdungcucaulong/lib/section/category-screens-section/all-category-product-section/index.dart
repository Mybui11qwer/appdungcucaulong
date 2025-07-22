import 'package:appdungcucaulong/class/index.dart';
import 'package:appdungcucaulong/components/custom-sliver-grid/index.dart';
import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:appdungcucaulong/components/product-card/index.dart';
import 'package:appdungcucaulong/const/raw.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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

class _AllCategoryProductSectionState extends State<AllCategoryProductSection> with TickerProviderStateMixin {
  int onSortOpt = 0;
  late AnimationController controller;
  late Animation<double> animation;
  final BoxSize boxSize = BoxSize(height: 400, width: 400 ,padding: const EdgeInsets.all(10));


  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward()
          ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        //Phần để filter
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 60,
          width: screenWidth,
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 0.5,
                blurRadius: 1,
                offset: Offset(0, 2), //
              )
            ]
          ),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: sortOptionsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: ()=>{setState(() {
                    onSortOpt = index;
                  })},
                  child: Container(
                    child: Center(
                      child: Row(
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return ScaleTransition(scale: animation, child: child);
                            },
                            child: Icon(
                              sortOptionsList[index].optIcon,
                              size: index == onSortOpt ? 24 : 20,
                              color: index == onSortOpt ? Colors.blueAccent : Colors.black87,
                              key: ValueKey(index == onSortOpt ? sortOptionsList[index].optIcon : 'unselected_$index'),
                            ),
                          ),
                          SizedBox(width: 5),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                            child: CustomTitle(
                              key: ValueKey(index == onSortOpt ? sortOptionsList[index].optIcon : 'unselected_$index'),
                              text: sortOptionsList[index].option, 
                              txtSize: 14,
                              color: index == onSortOpt ? Colors.blueAccent : Colors.black87,
                              fontWeight:  index == onSortOpt ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 20), // Khoảng cách giữa các item
          ),
        ),
        SizedBox(height: 20,),
        SizedBox(
            height: 730,
            child: Container(
              width: screenWidth-20,
              child: CustomSilverGrid(
                quantity: 4,
                aspectRatio: 0.58,
                itemBuilder: ((context, index) =>
                 ProductCardVer2(boxSize: boxSize, product: Raw.produtCardModelSneaker,)),
              ),
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/Navigation_bottom/bookmarkscreen.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/Navigation_bottom/explorescreen.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/Navigation_bottom/homescreen.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/Navigation_bottom/profilescreen.dart';
import 'package:tour_guide_metaverse/shared/helpers/helperMethods.dart';

import '../../shared/styles/styles.dart';

class TourismPage extends StatefulWidget {
  const TourismPage({Key? key}) : super(key: key);
  static const String routeName = "tourism_page";

  @override
  State<TourismPage> createState() => _TourismPageState();
}

class _TourismPageState extends State<TourismPage> {
  int index = 0;
  final _pagebottom = [
    HomeScreen(),
    ExploreScreen(),
    BookMarkScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      HelperMethods.getHistoryInfo(context);
      HelperMethods.getCurrentUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pagebottom[index],
      bottomNavigationBar: BottomAppBar(
        color: base,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 10,
            top: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildContainerIconButton(Icons.home_outlined, 0),
              buildContainerIconButton(Icons.explore_outlined, 1),
              buildContainerIconButton(Icons.bookmark_border, 2),
              buildContainerIconButton(Icons.person_2_outlined, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainerIconButton(IconData iconData, int buttonIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          index = buttonIndex;
        });
      },
      child: Container(
        height: 7.h,
        width: 15.w,
        decoration: BoxDecoration(
          color: index == buttonIndex ? Colors.yellow : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(10),
        child: IconButton(
          onPressed: () {
            setState(() {
              index = buttonIndex;
            });
          },
          icon: Icon(
            iconData,
            color: index == buttonIndex ? base : Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}


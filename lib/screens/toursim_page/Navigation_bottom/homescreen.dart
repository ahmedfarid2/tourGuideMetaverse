import 'package:flutter/material.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/navigationNail/CHATGPT.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/navigationNail/OFFLINE.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/navigationNail/metaverse_tour.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "home_page";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final _pagesleft = [
    METAVERSE(),
    OFFLINE(),
    CHATGPT(),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: NavigationRail(
            selectedLabelTextStyle: TextStyle(
              color: Color(0xFFC58940),
              fontSize: 20,
              fontFamily: 'Brand-Bold',
            ),
            unselectedLabelTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'Brand-Bold',
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 30.0),
            ),
            labelType: NavigationRailLabelType.all,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              NavigationRailDestination(
                icon: const Icon(null),
                label: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'MeTAVERSE',
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: const Icon(null),
                label: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'TOUR OFFLINE',
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: const Icon(null),
                label: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'GAME',
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: PageScrollPhysics(),
            child: _pagesleft[_selectedIndex],
          ),
        ),
      ],
    );
  }
}

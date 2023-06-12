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
              color: Colors.orange[900],
              fontSize: 17,
              fontFamily: 'Brand-Bold',
            ),
            unselectedLabelTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'Brand-Bold',
            ),
            trailing: const Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            labelType: NavigationRailLabelType.all,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(null),
                label: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'MeTAVERSE',
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(null),
                label: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'TOUR OFFLINE',
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(null),
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
            physics: const PageScrollPhysics(),
            child: _pagesleft[_selectedIndex],
          ),
        ),
      ],
    );
  }
}

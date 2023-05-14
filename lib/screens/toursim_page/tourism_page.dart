import 'package:flutter/material.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/CHATGPT.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/OFFLINE.dart';

import 'metaverse_tour.dart';

class TourismPage extends StatefulWidget {
  const TourismPage({Key? key}) : super(key: key);
  static const String routeName = "tourism_page";

  @override
  State<TourismPage> createState() => _TourismPageState();
}

class _TourismPageState extends State<TourismPage> {
  int index = 0;
  int _selectedIndex = 0;
  final _pages = [
    METAVERSE(),
    CHATGPT(),
    OFFLINE(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 50,
              width: 50,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              'METAPHAROH',
              style: TextStyle(
                fontFamily: 'Brand-Bold',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFFC58940),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Row(
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
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconSize: 30,
        onTap: (value) {
          index = value;
          setState(() {});
        },
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Color(0xFFC58940),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
            ),
            label: 'SETTINGS',
          ),
        ],
      ),
    );
  }
}

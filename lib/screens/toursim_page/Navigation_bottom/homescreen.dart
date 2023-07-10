import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/navigationNail/CHATGPT.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/navigationNail/OFFLINE.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/navigationNail/metaverse_tour.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: base,
        elevation: 0.0,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                'assets/images/logo.png',
                height: 40,
                width: 50,
              ),
            ),
            const SizedBox(
              width: 7.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'enjoy',
                  style: GoogleFonts.raleway(
                    fontSize: 14,
                    color: white.withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'METAPHAROH',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: base,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: NavigationRail(
                backgroundColor: base,
                selectedLabelTextStyle: GoogleFonts.raleway(
                  color: Colors.yellow,
                  fontWeight: FontWeight.w800,
                  fontSize: 19,
                ),
                unselectedLabelTextStyle: GoogleFonts.raleway(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
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
                        'Metaverse',
                      ),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: Icon(null),
                    label: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'Tour Offline',
                      ),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: Icon(null),
                    label: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'Game',
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
        ),
      ),
    );
  }
}

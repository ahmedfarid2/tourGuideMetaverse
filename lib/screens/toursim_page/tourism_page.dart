import 'package:flutter/material.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/Navigation_bottom/homescreen.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/Navigation_bottom/profilescreen.dart';

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
    ProfileScreen(),
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
                color: Colors.orange[900],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: _pagebottom[index],
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
        selectedItemColor: Colors.orange[900],
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
            ),
            label: 'PROFILE',
          ),
        ],
      ),
    );
  }
}

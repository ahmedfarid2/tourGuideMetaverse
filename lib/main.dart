import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide_metaverse/screens/history_page/historypage.dart';
import 'package:tour_guide_metaverse/screens/intro_app/first_intro.dart';
import 'package:tour_guide_metaverse/screens/intro_app/second_intro.dart';
import 'package:tour_guide_metaverse/screens/intro_app/third_intro.dart';
import 'package:tour_guide_metaverse/screens/login_screen/login_screen.dart';
import 'package:tour_guide_metaverse/screens/mainpage.dart';
import 'package:tour_guide_metaverse/screens/register_screen/register_screen.dart';
import 'package:tour_guide_metaverse/screens/search_page/searchPage.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/tourism_page.dart';
import 'package:tour_guide_metaverse/shared/constants/constants.dart';
import 'package:tour_guide_metaverse/shared/data_provider/appdata.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // firebase login
    options: DefaultFirebaseOptions.currentPlatform,
  );

  currentFirebaseUser = await FirebaseAuth.instance.currentUser;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppData(),
      child: MaterialApp(
        title: 'Tour Guide App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Brand-Regular',
          primaryColor: Color(0xFFE5BA73),
        ),
        initialRoute: (currentFirebaseUser == null)
            ? FirstIntro.routeName
            : TourismPage.routeName,
        routes: {
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          MainPage.routeName: (context) => const MainPage(),
          SearchPage.routeName: (context) => const SearchPage(),
          HistoryPage.routeName: (context) => const HistoryPage(),
          TourismPage.routeName: (context) => const TourismPage(),
          FirstIntro.routeName: (context) => const FirstIntro(),
          SecondIntro.routeName: (context) => const SecondIntro(),
          ThirdIntro.routeName: (context) => const ThirdIntro(),
        },
      ),
    );
  }
}

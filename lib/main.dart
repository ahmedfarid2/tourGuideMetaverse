import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide_metaverse/screens/login_screen/login_screen.dart';
import 'package:tour_guide_metaverse/screens/mainpage.dart';
import 'package:tour_guide_metaverse/screens/register_screen/register_screen.dart';
import 'package:tour_guide_metaverse/screens/search_page/searchPage.dart';
import 'package:tour_guide_metaverse/shared/constants/constants.dart';
import 'package:tour_guide_metaverse/shared/data_provider/appdata.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // firebase login
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
          primarySwatch: Colors.blue,
        ),
        initialRoute: (currentFirebaseUser == null)
            ? LoginScreen.routeName
            : MainPage.routeName,
        routes: {
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          MainPage.routeName: (context) => const MainPage(),
          SearchPage.routeName: (context) => const SearchPage(),
        },
      ),
    );
  }
}

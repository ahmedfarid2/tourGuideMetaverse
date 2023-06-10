import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/screens/ForgotPasswordScreen/ForgotPasswordScreen.dart';
import 'package:tour_guide_metaverse/screens/OculusConnectionScreen.dart';
import 'package:tour_guide_metaverse/screens/ResetPassword/ResetPassword.dart';
import 'package:tour_guide_metaverse/screens/VerifyForgotPassword/VerifyForgotPassword.dart';
import 'package:tour_guide_metaverse/screens/VerifyIdentityScreen/VerifyIdentityScreen.dart';
import 'package:tour_guide_metaverse/screens/history_page/historypage.dart';
import 'package:tour_guide_metaverse/screens/intro_app/first_intro.dart';
import 'package:tour_guide_metaverse/screens/intro_app/second_intro.dart';
import 'package:tour_guide_metaverse/screens/intro_app/third_intro.dart';
import 'package:tour_guide_metaverse/screens/login_screen/login_screen.dart';
import 'package:tour_guide_metaverse/screens/login_screen/login_screen2.dart';
import 'package:tour_guide_metaverse/screens/mainpage.dart';
import 'package:tour_guide_metaverse/screens/places_datails/PlaceDetails.dart';
import 'package:tour_guide_metaverse/screens/register_screen/register_screen.dart';
import 'package:tour_guide_metaverse/screens/register_screen/register_screen2.dart';
import 'package:tour_guide_metaverse/screens/search_page/searchPage.dart';
import 'package:tour_guide_metaverse/screens/terms_of_service/terms_of_service.dart';
import 'package:tour_guide_metaverse/screens/tour_guide_details/tourGuideDetails.dart';
import 'package:tour_guide_metaverse/screens/tourguide_list/tourguide_list.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/tourism_page.dart';
import 'package:tour_guide_metaverse/shared/constants/constants.dart';
import 'package:tour_guide_metaverse/shared/data_models/destination_model.dart';
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
    List<Destination> popular =
        destinations.where((element) => element.category == 'popular').toList();
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppData(),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'Tour Guide App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Brand-Regular',
              primaryColor: Colors.orange[900],
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
              OculusConnectionScreen.routeName: (context) =>
                  OculusConnectionScreen(),
              TourGuideDetails.routeName: (context) => TourGuideDetails(),
              PlaceDetailsScreen.routeName: (context) => PlaceDetailsScreen(
                    destination: popular[0],
                  ),
              TourGuideList.routeName: (context) => TourGuideList(
                    destination: popular[0],
                  ),
              TermsOfServiceScreen.routeName: (context) =>
                  TermsOfServiceScreen(),
              VerifyIdentityScreen.routeName: (context) => VerifyIdentityScreen(
                    destination: popular[0],
                  ),
              LoginScreen2.routeName: (context) => LoginScreen2(
                    destination: popular[0],
                  ),
              RegisterScreen2.routeName: (context) => RegisterScreen2(
                    destination: popular[0],
                  ),
              ForgotPasswordScreen.routeName: (context) =>
                  ForgotPasswordScreen(),
              VerifyForgotPassword.routeName: (context) =>
                  VerifyForgotPassword(),
              ResetPassword.routeName: (context) => ResetPassword(),
            },
          );
        },
      ),
    );
  }
}

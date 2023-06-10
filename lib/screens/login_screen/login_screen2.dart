import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/screens/ForgotPasswordScreen/ForgotPasswordScreen.dart';
import 'package:tour_guide_metaverse/screens/register_screen/register_screen2.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/tourism_page.dart';
import 'package:tour_guide_metaverse/shared/data_models/destination_model.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/CustomizedTextfield.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/progressDialog.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class LoginScreen2 extends StatefulWidget {
  final Destination destination;

  LoginScreen2({Key? key, required this.destination}) : super(key: key);
  static const String routeName = "login2";

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailControler = TextEditingController();

  final TextEditingController passwordControler = TextEditingController();

  void login() async {
    //show wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          const ProgressDialog(status: 'Logging you in'),
    );

    final User? user = (await _auth
            .signInWithEmailAndPassword(
                email: emailControler.text, password: passwordControler.text)
            .catchError((ex) {
      Navigator.pop(context);
      PlatformException thisEx = ex;
      showSnackbar(thisEx.message);
    }))
        .user;

    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users/${user.uid}');
      userRef.once().then((DatabaseEvent databaseEvent) {
        if (databaseEvent.snapshot.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, TourismPage.routeName, (route) => false);
        }
      });
    }
  }

  void showSnackbar(String? title) {
    final snackbar = SnackBar(
      content: Text(
        title!,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15.0),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  PageController pageController = PageController();
  int pageView = 0;
  int tappedIndex = -1;
  bool isPressed = false;
  double selectedRating = 0.0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    pageController = PageController();

    // Start the timer
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      // Increment the page index
      final nextPage = (pageView + 1) % widget.destination.image!.length;
      pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Destination> popular =
        destinations.where((element) => element.category == 'popular').toList();
    return Scaffold(
      backgroundColor: base,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: base,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: base,
              child: Stack(
                children: [
                  Container(
                    height: 45.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (value) {
                          setState(() {
                            pageView = value;
                          });
                        },
                        children: List.generate(
                          widget.destination.image!.length,
                          (index) => ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [Colors.transparent, base],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.darken,
                            child: Image.asset(
                              'assets/${widget.destination.image![index]}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 6.w,
                        bottom: 1.h,
                      ),
                      child: Text(
                        'Login',
                        style: GoogleFonts.raleway(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.h,
                    right: 0.w,
                    child: Container(
                      padding: EdgeInsets.only(
                        right: 6.w,
                        top: 6.h,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: white,
                            size: 8.sp,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.destination.location!,
                            style: GoogleFonts.raleway(
                              fontSize: 6.sp,
                              color: white.withOpacity(0.6),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.w, 0, 6.w, 0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                CustomizedTextfield(
                                  myController: emailControler,
                                  hintText: "Email Id",
                                  isPassword: false,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Form(
                                    child: TextField(
                                      obscureText: true,
                                      controller: passwordControler,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1),
                                        ),
                                        hintText: 'Password',
                                        hintStyle: GoogleFonts.raleway(
                                          color: Colors.grey,
                                          fontSize: 10.sp,
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: Colors.yellow,
                                          size: 12.sp,
                                        ),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(
                                            right: 4.0.w,
                                          ),
                                          child: Container(
                                            width: 10.w,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      ForgotPasswordScreen
                                                          .routeName,
                                                      arguments:
                                                          ForgotPasswordScreen(),
                                                    );
                                                  },
                                                  child: Text(
                                                    'Forgot?',
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 8.sp,
                                                      color: Colors.yellow,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: InkWell(
                                          onTap: () async {
                                            var connectivityResult =
                                                await Connectivity()
                                                    .checkConnectivity();
                                            if (connectivityResult !=
                                                    ConnectivityResult.mobile &&
                                                connectivityResult !=
                                                    ConnectivityResult.wifi) {
                                              showSnackbar(
                                                  "No internet connectivity");
                                              return;
                                            }
                                            if (!emailControler.text
                                                .contains('@')) {
                                              showSnackbar(
                                                  "please enter a valid email");
                                              return;
                                            }
                                            if (passwordControler.text.length <
                                                8) {
                                              showSnackbar(
                                                  "Password must be at least 8 characters");
                                              return;
                                            }
                                            login();
                                          },
                                          child: Container(
                                            height: 8.h,
                                            decoration: BoxDecoration(
                                                color: yellow,
                                                border: Border.all(
                                                    width: 1, color: yellow),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.sp)),
                                            child: Center(
                                              child: Text(
                                                'Login',
                                                style: GoogleFonts.raleway(
                                                  fontSize: 10.sp,
                                                  color: base,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1.h,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 8.h,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.transparent,
                                                width: 1),
                                            // Set border color to transparent
                                            borderRadius:
                                                BorderRadius.circular(12.sp),
                                            color: Colors
                                                .white24, // Set grey color for the container
                                          ),
                                          child: Center(
                                            child: IconButton(
                                              icon: Image.asset(
                                                'assets/images/scan.png',
                                                color: Colors.yellow,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Center(
                                    child: Text(
                                  "Or Login with",
                                  style: GoogleFonts.raleway(
                                    fontSize: 8.sp,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(6.7.w, 0, 8.w, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 7.h,
                              width: 22.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.transparent,
                                    width:
                                        1), // Set border color to transparent
                                borderRadius: BorderRadius.circular(12.sp),
                                color: Colors
                                    .white24, // Set grey color for the container
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.facebook,
                                  color: white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Container(
                              height: 7.h,
                              width: 22.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.transparent, width: 1),
                                borderRadius: BorderRadius.circular(12.sp),
                                color: Colors.white24,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.g_mobiledata_rounded,
                                  color: white,
                                  size: 25.sp,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Container(
                              height: 7.h,
                              width: 22.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.transparent, width: 1),
                                borderRadius: BorderRadius.circular(12.sp),
                                color: Colors.white24,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.apple,
                                  color: white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 6.w,
                          bottom: 1.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New user?",
                              style: GoogleFonts.raleway(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 10.sp),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RegisterScreen2.routeName,
                                    arguments: RegisterScreen2(
                                      destination: popular[0],
                                    ),
                                    (route) => false);
                              },
                              child: Text(
                                "  Register Here",
                                style: GoogleFonts.raleway(
                                    color: Colors.yellow, fontSize: 10.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

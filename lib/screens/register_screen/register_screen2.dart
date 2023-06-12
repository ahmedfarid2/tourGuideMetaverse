import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/screens/VerifyIdentityScreen/VerifyIdentityScreen.dart';
import 'package:tour_guide_metaverse/screens/login_screen/login_screen2.dart';
import 'package:tour_guide_metaverse/shared/data_models/destination_model.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/CustomizedButton.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/CustomizedTextfield.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/progressDialog.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class RegisterScreen2 extends StatefulWidget {
  final Destination destination;
  static const String routeName = "register2";

  const RegisterScreen2({Key? key, required this.destination})
      : super(key: key);

  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController nameControler = TextEditingController();

  final TextEditingController phoneControler = TextEditingController();

  final TextEditingController emailControler = TextEditingController();

  final TextEditingController passwordControler = TextEditingController();

  void registerUser() async {
    //show wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          const ProgressDialog(status: 'Registering you...'),
    );
    final User? user = (await _auth
            .createUserWithEmailAndPassword(
                email: emailControler.text, password: passwordControler.text)
            .catchError((ex) {
      Navigator.pop(context);
      PlatformException thisEx = ex;
      showSnackbar(thisEx.message);
    }))
        .user;

    Navigator.pop(context);

    if (user != null) {
      DatabaseReference newUserRef =
          FirebaseDatabase.instance.ref().child('users/${user.uid}');

      Map userMap = {
        'name': nameControler.text,
        'email': emailControler.text,
        'phone': phoneControler.text,
      };

      newUserRef.set(userMap);

      Navigator.pushNamedAndRemoveUntil(
          context, VerifyIdentityScreen.routeName, (route) => false);
    }
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
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      // Increment the page index
      final nextPage = (pageView + 1) % widget.destination.image!.length;
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
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
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
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
                              return const LinearGradient(
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
                        'Register',
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
              height: 2.h,
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.w, 0, 6.w, 0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                CustomizedTextfield(
                                  myController: nameControler,
                                  hintText: "Full Name",
                                  isPassword: false,
                                  keyboardType: TextInputType.text,
                                ),
                                CustomizedTextfield(
                                  myController: emailControler,
                                  hintText: "Email Id",
                                  isPassword: false,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                CustomizedTextfield(
                                  myController: phoneControler,
                                  hintText: "Phone",
                                  isPassword: false,
                                  keyboardType: TextInputType.number,
                                ),
                                CustomizedTextfield(
                                  myController: passwordControler,
                                  hintText: "Password",
                                  isPassword: true,
                                  keyboardType: TextInputType.text,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            CustomizedButton(
                              buttonText: "Register",
                              buttonColor: yellow,
                              textColor: Colors.white,
                              onPressed: () async {
                                var connectivityResult =
                                    await Connectivity().checkConnectivity();
                                if (connectivityResult !=
                                        ConnectivityResult.mobile &&
                                    connectivityResult !=
                                        ConnectivityResult.wifi) {
                                  showSnackbar("No internet connectivity");
                                  return;
                                }
                                if (nameControler.text.length < 7) {
                                  showSnackbar(
                                      "Name must be at least 7 characters");
                                  return;
                                }
                                if (!emailControler.text.contains('@')) {
                                  showSnackbar("please enter a valid email");
                                  return;
                                }
                                if (phoneControler.text.length < 10) {
                                  showSnackbar(
                                      "please enter a valid phone number");
                                  return;
                                }
                                if (passwordControler.text.length < 8) {
                                  showSnackbar(
                                      "Password must be at least 8 characters");
                                  return;
                                }
                                registerUser();
                              },
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Center(
                                child: Text(
                              "Or Register with",
                              style: GoogleFonts.raleway(
                                fontSize: 8.sp,
                                color: Colors.white.withOpacity(0.6),
                              ),
                            )),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                        ),
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
                              "Already have an account?",
                              style: GoogleFonts.raleway(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 10.sp),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  LoginScreen2.routeName,
                                  arguments: LoginScreen2(
                                    destination: popular[0],
                                  ),
                                );
                              },
                              child: Text(
                                "  Login Now",
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

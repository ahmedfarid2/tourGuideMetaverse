import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tour_guide_metaverse/screens/AccountSetupScreen/AccountSetupScreen.dart';
import 'package:tour_guide_metaverse/screens/terms_of_service/terms_of_service.dart';
import 'package:tour_guide_metaverse/shared/data_models/destination_model.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/CustomizedButton.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class VerifyIdentityScreen extends StatefulWidget {
  final Destination destination;

  const VerifyIdentityScreen({Key? key, required this.destination})
      : super(key: key);
  static const String routeName = "VerifyIdentityScreen";

  @override
  State<VerifyIdentityScreen> createState() => _VerifyIdentityScreenState();
}

class _VerifyIdentityScreenState extends State<VerifyIdentityScreen> {
  PageController pageController = PageController();
  int pageView = 0;
  int tappedIndex = -1;
  bool isPressed = false;
  double selectedRating = 0.0;
  Timer? timer;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String codeValue = "";

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
                    height: 50.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15.sp),
                        bottomLeft: Radius.circular(15.sp),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Verify Your \n Identity',
                            style: GoogleFonts.raleway(
                              fontSize: 30.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            'We have just sent a verification code to ',
                            style: GoogleFonts.raleway(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 10.sp),
                          ),
                          Text(
                            'john.doe@gmail.com',
                            style: GoogleFonts.raleway(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 10.sp),
                          ),
                          //Text('${_emailController}',),
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 0,
                  //   left: 0,
                  //   child: Container(
                  //     padding: EdgeInsets.only(
                  //       left: 6.w,
                  //       top: 6.h,
                  //     ),
                  //     child: IconButton(
                  //       onPressed: () {
                  //         // Navigator.pushNamed(
                  //         //   context,
                  //         //   '/Register',
                  //         //   arguments:
                  //         //   RegisterScreen(destination: popular[0]),
                  //         // );
                  //       },
                  //       icon: Icon(
                  //         Icons.arrow_back_sharp,
                  //         color: white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.only(
                        right: 6.w,
                        top: 8.h,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: white,
                            size: 8.sp,
                          ),
                          SizedBox(width: 1.w),
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
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5.w, 0, 6.w, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Center(
                            child: SizedBox(
                              height: 8.h, // Set the desired height here
                              child: PinFieldAutoFill(
                                currentCode: codeValue,
                                codeLength: 4,
                                decoration: UnderlineDecoration(
                                  textStyle: GoogleFonts.raleway(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  colorBuilder: FixedColorBuilder(
                                      Colors.white.withOpacity(0.6)),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                // Restrict to numbers only
                                onCodeChanged: (code) {
                                  print("onCodeChanged $code");
                                  setState(() {
                                    codeValue = code.toString();
                                  });
                                },
                                onCodeSubmitted: (val) {
                                  print("onCodeSubmitted $val");
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Didnt receive the code?',
                              style: GoogleFonts.raleway(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 10.sp),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "  Resend code",
                                style: GoogleFonts.raleway(
                                    color: Colors.yellow, fontSize: 10.sp),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        CustomizedButton(
                          buttonText: "Verification",
                          buttonColor: yellow,
                          onPressed: () async {
                            Navigator.pushNamed(
                              context,
                              AccountSetupScreen.routeName,
                              arguments: AccountSetupScreen(),
                            );
                          },
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 6.w,
                            bottom: 1.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'By registering you agree to our',
                                    style: GoogleFonts.raleway(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 10.sp),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        TermsOfServiceScreen.routeName,
                                        arguments: const TermsOfServiceScreen(),
                                      );
                                    },
                                    child: Text(
                                      "  Terms of Service",
                                      style: GoogleFonts.raleway(
                                          color: Colors.yellow,
                                          fontSize: 10.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

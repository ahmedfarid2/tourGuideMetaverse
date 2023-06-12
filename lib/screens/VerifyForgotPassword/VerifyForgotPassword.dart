import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tour_guide_metaverse/screens/ForgotPasswordScreen/ForgotPasswordScreen.dart';
import 'package:tour_guide_metaverse/screens/ResetPassword/ResetPassword.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/CustomizedButton.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class VerifyForgotPassword extends StatefulWidget {
  static const String routeName = "VerifyForgotPassword";

  @override
  _VerifyForgotPasswordState createState() => _VerifyForgotPasswordState();
}

class _VerifyForgotPasswordState extends State<VerifyForgotPassword> {
  String codeValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: base,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(
            left: 1.w,
          ),
          child: Center(
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ForgotPasswordScreen.routeName,
                  arguments: ForgotPasswordScreen(),
                );
              },
            ),
          ),
        ),
        backgroundColor: base,
        toolbarHeight: 10.h,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(6.w, 6.h, 6.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60.w,
              child: Text(
                'Verification code',
                style: GoogleFonts.raleway(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
                maxLines: 2,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Please select your contact details and we will send a verification code to reset your password',
              style: GoogleFonts.raleway(
                fontSize: 10.sp,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 4.h),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Center(
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
                          colorBuilder:
                              FixedColorBuilder(Colors.white.withOpacity(0.6)),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
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
                    height: 30.h,
                  ),
                  CustomizedButton(
                    buttonText: "Verification",
                    buttonColor: yellow,
                    onPressed: () async {
                      Navigator.pushNamed(
                        context,
                        ResetPassword.routeName,
                        arguments: ResetPassword(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

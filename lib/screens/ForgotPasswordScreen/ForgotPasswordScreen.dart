import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/screens/login_screen/login_screen2.dart';
import 'package:tour_guide_metaverse/shared/data_models/destination_model.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/Selection.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class ForgotPasswordScreen extends StatelessWidget {
  List<Destination> popular =
      destinations.where((element) => element.category == 'popular').toList();
  static const String routeName = "ForgotPassword";

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
                  LoginScreen2.routeName,
                  arguments: LoginScreen2(
                    destination: popular[0],
                  ),
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
                'Forgot Password',
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
            Selection(
              prefixIcon: Icons.phone_iphone_outlined,
              constantText: 'Phone Number',
              hintText: '01120744802',
            ),
            SizedBox(height: 3.h),
            Selection(
              prefixIcon: Icons.email_outlined,
              constantText: 'Primary email',
              hintText: 'emanpepars7@gmail.com',
            ),
            SizedBox(height: 3.h),
            Selection(
              prefixIcon: Icons.email_outlined,
              constantText: 'Secondary email',
              hintText: 'emanpepars57@gmail.com',
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}

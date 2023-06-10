import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/screens/VerifyForgotPassword/VerifyForgotPassword.dart';

class Selection extends StatelessWidget {
  final IconData prefixIcon;
  final String constantText;
  final String hintText;

  Selection({
    required this.prefixIcon,
    required this.constantText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 11.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0.sp),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            VerifyForgotPassword.routeName,
            arguments: VerifyForgotPassword(),
          );
          // Add your button press logic here
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                prefixIcon,
                size: 15.sp,
                color: Colors.yellow,
              ),
              SizedBox(width: 3.w),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      constantText,
                      style: GoogleFonts.raleway(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 8.sp,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      getSecureText(hintText),
                      style: GoogleFonts.raleway(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getSecureText(String hintText) {
  if (hintText.contains('@')) {
    if (hintText.endsWith('.com')) {
      // Primary or secondary email
      final index = hintText.lastIndexOf('@');
      final domain = hintText.substring(index + 1);
      final username = hintText.substring(0, index);
      final secureUsername = username.replaceAll(RegExp(r'[a-zA-Z0-9]'), '.') +
          username.substring(username.length - 2) +
          '@' +
          domain;
      return secureUsername;
    }
  } else if (RegExp(r'\d').hasMatch(hintText)) {
    // Number
    return hintText.substring(0, 7).replaceAll(RegExp(r'[a-zA-Z0-9]'), '.') +
        hintText.substring(7);
  }
  return hintText;
}

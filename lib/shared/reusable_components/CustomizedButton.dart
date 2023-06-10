import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class CustomizedButton extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final VoidCallback? onPressed;

  const CustomizedButton(
      {Key? key,
      this.buttonText,
      this.buttonColor,
      this.onPressed,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
            height: 8.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: yellow,
                border: Border.all(width: 1, color: yellow),
                borderRadius: BorderRadius.circular(12.sp)),
            child: Center(
                child: Text(
              buttonText!,
              style: GoogleFonts.raleway(
                fontSize: 10.sp,
                color: base,
                fontWeight: FontWeight.w600,
              ),
            ))),
      ),
    );
  }
}

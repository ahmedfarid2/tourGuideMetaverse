import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: base,
      child: Padding(
        padding: EdgeInsets.only(
          top: 8.h,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 7.5.h,
              left: 4.w,
              child: Text(
                "Nearby \nDestination",
                style: GoogleFonts.raleway(
                  fontSize: 25.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 2,
              ),
            ),
            Positioned(
              top: 12.5.h,
              right: 4.w,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 35.w,
              bottom: 9.h,
              child: Container(
                width: 32.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings_input_antenna,
                        color: Colors.yellow,
                        size: 8.0.sp,
                      ),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      Text(
                        "destination too far",
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 40.w,
              bottom: 6.h,
              child: Text(
                'From your Location',
                style: GoogleFonts.raleway(
                  color: white.withOpacity(0.6),
                  fontWeight: FontWeight.normal,
                  fontSize: 8.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                        Colors.transparent
                      ],
                      stops: [0.0, 0.05, 0.95, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child:
                      Image.asset('assets/images/map.png', fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

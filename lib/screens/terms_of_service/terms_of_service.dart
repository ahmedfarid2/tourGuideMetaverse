import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/screens/VerifyIdentityScreen/VerifyIdentityScreen.dart';
import 'package:tour_guide_metaverse/shared/data_models/destination_model.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({Key? key}) : super(key: key);
  static const String routeName = "TermsOfService";

  @override
  Widget build(BuildContext context) {
    List<Destination> popular =
        destinations.where((element) => element.category == 'popular').toList();
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
                  VerifyIdentityScreen.routeName,
                  arguments: VerifyIdentityScreen(
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
        padding: EdgeInsets.fromLTRB(4.0.w, 2.0.h, 4.0.w, 1.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 7.h,
                    width: 12.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent, width: 1),
                      borderRadius: BorderRadius.circular(12.sp),
                      color: Colors.white24,
                    ),
                    child: Icon(
                      Icons.description_outlined,
                      color: yellow,
                      size: 15.sp,
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Terms of Service",
                          style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontSize: 15.sp)),
                      SizedBox(
                        height: 0.5.w,
                      ),
                      Text('last update july 2023',
                          style: GoogleFonts.raleway(
                              fontWeight: FontWeight.normal,
                              color: white.withOpacity(0.6),
                              fontSize: 9.sp)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(
                color: Colors.white24,
                height: 0.1.h, // Adjust the height of the line
                thickness: 0.1.h, // Adjust the thickness of the line
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                '1. YOUR AGREEMENT\n',
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 0.h,
              ),
              Text(
                  'By using this Site, you agree to be bound by, and to comply with, these Terms and Conditions. '
                  'If you do not agree to these Terms and Conditions, please do not use this site.\n'
                  '\n'
                  'PLEASE NOTE: We reserve the right, at our sole discretion, to change, modify, '
                  'or otherwise alter these Terms and Conditions at any time. Unless otherwise indicated, '
                  'amendments will become effective immediately. Please review these Terms and Conditions '
                  'periodically. Your continued use of the Site following the posting of changes and/or '
                  'modifications will constitute your acceptance of the revised Terms and Conditions and '
                  'the reasonableness of these standards for notice of changes. For your information, this '
                  'page was last updated as of the date at the top of these terms and conditions.',
                  style: GoogleFonts.raleway(
                      fontWeight: FontWeight.normal,
                      color: white.withOpacity(0.6),
                      fontSize: 9.sp)),
              const SizedBox(height: 16.0),
              Text(
                '2. PRIVACY\n',
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                  'Please review our Privacy Policy, which also governs your visit to this Site, to '
                  'understand our practices.',
                  style: GoogleFonts.raleway(
                      fontWeight: FontWeight.normal,
                      color: white.withOpacity(0.6),
                      fontSize: 9.sp)),
            ],
          ),
        ),
      ),
    );
  }
}

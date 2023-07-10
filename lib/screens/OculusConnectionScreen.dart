import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../shared/styles/styles.dart';

class OculusConnectionScreen extends StatelessWidget {
  static const String routeName = "oculus_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Connect Your Oculus Quest',
          style: GoogleFonts.raleway(
              fontSize: 14.sp, color: white, fontWeight: FontWeight.w800),
        ),
        backgroundColor: base,
      ),
      body: Container(
        color: base,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/oculus.png',
                  height: 300,
                  width: 300,
                ),
                const SizedBox(height: 40),
                Text(
                  'To join the MetaPharaoh metaverse, please follow these steps:',
                  style: GoogleFonts.raleway(
                      fontSize: 10.sp,
                      color: white,
                      fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Step 1: Download the Oculus app on your mobile device.',
                  style: GoogleFonts.raleway(
                      fontSize: 10.sp,
                      color: white,
                      fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Step 2: Connect your Oculus Quest headset to the companion app.',
                  style: GoogleFonts.raleway(
                      fontSize: 10.sp,
                      color: white,
                      fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Step 3: Once connected, open the MetaPharaoh app on your headset.',
                  style: GoogleFonts.raleway(
                      fontSize: 10.sp,
                      color: white,
                      fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.yellow.withOpacity(0.4)),
                      ),
                      child: Text(
                        'Download Oculus App',
                        style: GoogleFonts.raleway(
                            fontSize: 10.sp,
                            color: white,
                            fontWeight: FontWeight.w800),
                      ),
                      onPressed: () {
                        // Open a URL or deep link to the Oculus companion app
                        // You can use a package like url_launcher to achieve this.
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

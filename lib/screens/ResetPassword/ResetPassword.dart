import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/screens/ForgotPasswordScreen/ForgotPasswordScreen.dart';
import 'package:tour_guide_metaverse/screens/login_screen/login_screen2.dart';
import 'package:tour_guide_metaverse/shared/data_models/destination_model.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/CustomizedButton.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/CustomizedTextfield.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class ResetPassword extends StatefulWidget {
  static const String routeName = "resetPassword";

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  List<Destination> popular =
      destinations.where((element) => element.category == 'popular').toList();
  String codeValue = "";
  final TextEditingController _NewpasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
              icon: Icon(Icons.arrow_back),
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
                'Reset Password',
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
              'At least 8 characters, with uppercase lowercase and special character.',
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
                  CustomizedTextfield(
                    myController: _NewpasswordController,
                    hintText: "New Password",
                    isPassword: false,
                    keyboardType: TextInputType.text,
                  ),
                  CustomizedTextfield(
                    myController: _confirmPasswordController,
                    hintText: "Confirm Password",
                    isPassword: false,
                    keyboardType: TextInputType.text,
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
                    height: 23.h,
                  ),
                  CustomizedButton(
                      buttonText: "Update password",
                      buttonColor: yellow,
                      textColor: Colors.white,
                      onPressed: () async {
                        Navigator.pushNamed(
                          context,
                          '/LoginScreen',
                          arguments: LoginScreen2(
                            destination: popular[0],
                          ),
                        );
                      }),
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

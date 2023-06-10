import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomizedTextfield extends StatelessWidget {
  final TextEditingController myController;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomizedTextfield({
    required this.myController,
    required this.hintText,
    required this.isPassword,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: myController,
        keyboardType: keyboardType,
        enableSuggestions: isPassword ? false : true,
        autocorrect: isPassword ? false : true,
        obscureText: isPassword,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.raleway(
            color: Colors.grey,
            fontSize: 10.sp,
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          prefixIcon: hintText == "Full Name"
              ? Icon(
                  Icons.person_outline,
                  color: Colors.yellow,
                  size: 12.sp,
                )
              : hintText == "Email Id"
                  ? Icon(
                      Icons.mail_outline,
                      color: Colors.yellow,
                      size: 12.sp,
                    )
                  : hintText == "Password"
                      ? Icon(
                          Icons.lock_outline,
                          color: Colors.yellow,
                          size: 12.sp,
                        )
                      : hintText == "Phone"
                          ? Icon(
                              Icons.phone,
                              color: Colors.yellow,
                              size: 12.sp,
                            )
                          : null,
        ),
      ),
    );
  }
}

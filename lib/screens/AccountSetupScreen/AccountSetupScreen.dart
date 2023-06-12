import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/screens/RegisterComplete/RegisterComplete.dart';
import 'package:tour_guide_metaverse/shared/data_models/destination_model.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/CustomizedButton.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/CustomizedTextfield.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class AccountSetupScreen extends StatefulWidget {
  static const String routeName = "AccountSetupScreen";

  @override
  _AccountSetupScreenState createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  String codeValue = "";
  final TextEditingController _usernameController = TextEditingController();
  List<Destination> popular =
      destinations.where((element) => element.category == 'popular').toList();
  File? _image;

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
                Navigator.pop(context);
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
                'Account Setup',
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
              'Finish your account setup by uploading profile picture and set your username.',
              style: GoogleFonts.raleway(
                fontSize: 10.sp,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.24),
                      width: 0.3.w,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_image != null)
                        ClipOval(
                          child: Image.network(
                            _image!.path,
                            width: 30.w,
                            height: 20.h,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        Icon(
                          Icons.person,
                          size: 25.sp,
                          color: Colors.white24,
                        ),
                      Positioned(
                        bottom: 2.h,
                        right: 0.w,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: EdgeInsets.all(5.sp),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.file_upload_outlined,
                              size: 10.sp,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            CustomizedTextfield(
              myController: _usernameController,
              hintText: "username",
              isPassword: false,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 17.h,
            ),
            CustomizedButton(
              buttonText: "Create Account",
              buttonColor: yellow,
              onPressed: () async {
                Navigator.pushNamed(
                  context,
                  RegisterComplete.routeName,
                  arguments: RegisterComplete(
                    destination: popular[0],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }
}

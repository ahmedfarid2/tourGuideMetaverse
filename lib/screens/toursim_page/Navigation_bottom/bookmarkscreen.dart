import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: base,
        child: Padding(
          padding: EdgeInsets.only(left: 5.h, top: 11.h, bottom: 3.h),
          child: Column(
            children: [
              TextField(
                enableSuggestions: true,
                autocorrect: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  hintText: 'Your Bookmark',
                  hintStyle: GoogleFonts.raleway(
                    color: Colors.yellow,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w900,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Icon(Icons.search, color: Colors.yellow),
                  ),
                ),
                onChanged: (value) {
                  // Handle search query changes here
                },
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "It's empty \nin here",
                        style: GoogleFonts.raleway(
                          fontSize: 35.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 2,
                      ),
                      Text(
                        'Try add some destination to your bookmark',
                        style: GoogleFonts.raleway(
                          fontSize: 16.sp,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

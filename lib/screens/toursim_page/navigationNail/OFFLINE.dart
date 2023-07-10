import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../shared/styles/styles.dart';
import '../../mainpage.dart';

class OFFLINE extends StatefulWidget {
  @override
  _OFFLINEState createState() => _OFFLINEState();
}

class _OFFLINEState extends State<OFFLINE> {
  bool isPressed1 = false;
  bool isPressed2 = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 640,
          width: 330,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/images/meta2.jpeg',
                  height: 640,
                  width: 500,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: Container(
                      width: 15.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.yellow,
                              size: 13.sp,
                            ),
                            Text(
                              '4.9',
                              style: GoogleFonts.raleway(
                                fontSize: 10.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isPressed2 = !isPressed2;
                            });
                          },
                          icon: Icon(
                            isPressed2 ? Icons.bookmark : Icons.bookmark_border,
                            color: isPressed2 ? Colors.yellow : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60.w,
                          child: Text(
                            'Pyramids',
                            style: GoogleFonts.raleway(
                              fontSize: 25.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: white,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Giza, Egypt',
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                color: white.withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, bottom: 30, left: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          MainPage.routeName,
                        );
                      },
                      child: const Icon(Icons.arrow_forward),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(80.0, 40.0),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.yellow.withOpacity(0.4),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Container(
          height: 640,
          width: 330,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/images/meta1.jpeg',
                  height: 640,
                  width: 500,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isPressed1 = !isPressed1;
                            });
                          },
                          icon: Icon(
                            isPressed1 ? Icons.bookmark : Icons.bookmark_border,
                            color: isPressed1 ? Colors.yellow : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: Container(
                      width: 15.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.yellow,
                              size: 13.sp,
                            ),
                            Text(
                              '4.9',
                              style: GoogleFonts.raleway(
                                fontSize: 10.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60.w,
                          child: Text(
                            'El-Karnak Temple',
                            style: GoogleFonts.raleway(
                              fontSize: 25.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: white,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Luxor, Egypt',
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                color: white.withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, bottom: 30, left: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          MainPage.routeName,
                        );
                      },
                      child: const Icon(Icons.arrow_forward),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(80.0, 40.0),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.yellow.withOpacity(0.4),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }
}

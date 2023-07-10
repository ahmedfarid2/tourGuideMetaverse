import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/screens/login_screen/login_screen2.dart';
import 'package:tour_guide_metaverse/shared/constants/constants.dart';
import 'package:tour_guide_metaverse/shared/data_provider/appdata.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: base,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 20.w),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 14.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage('assets/images/pepars.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentUserInfo!.fullName!,
                              style: GoogleFonts.raleway(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color:
                                    Colors.white, // Change text color to white
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Egypt',
                              style: GoogleFonts.raleway(
                                fontSize: 10.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                (Provider.of<AppData>(context)
                                        .tripHistory
                                        .length)
                                    .toString(),
                                style: GoogleFonts.raleway(
                                    fontSize: 18.sp,
                                    color: white,
                                    fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Tours',
                                style: GoogleFonts.raleway(
                                    fontSize: 12.sp,
                                    color: white,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              '12',
                              style: GoogleFonts.raleway(
                                  fontSize: 18.sp,
                                  color: white,
                                  fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Reviews',
                              style: GoogleFonts.raleway(
                                  fontSize: 12.sp,
                                  color: white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '3',
                              style: GoogleFonts.raleway(
                                  fontSize: 18.sp,
                                  color: white,
                                  fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Favorites',
                              style: GoogleFonts.raleway(
                                  fontSize: 12.sp,
                                  color: white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Personal Information',
                        style: GoogleFonts.raleway(
                            fontSize: 18.sp,
                            color: white,
                            fontWeight: FontWeight.w800),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: white,
                        ),
                        onPressed: () {
                          // TODO: Implement edit button functionality.
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 16),
                      Text(
                        currentUserInfo!.fullName!,
                        style: GoogleFonts.raleway(
                            fontSize: 12.sp,
                            color: white,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.grey[600]),
                      const SizedBox(width: 16),
                      Text(
                        currentUserInfo!.email!,
                        style: GoogleFonts.raleway(
                            fontSize: 12.sp,
                            color: white,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.grey[600]),
                      const SizedBox(width: 16),
                      Text(
                        currentUserInfo!.phone!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Methods',
                        style: GoogleFonts.raleway(
                            fontSize: 18.sp,
                            color: white,
                            fontWeight: FontWeight.w800),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: white,
                        ),
                        onPressed: () {
                          // TODO: Implement add payment method button functionality.
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.credit_card, color: Colors.grey[600]),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Visa ** ** ** 1234',
                                style: GoogleFonts.raleway(
                                    fontSize: 12.sp,
                                    color: white,
                                    fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Expires 12/25',
                                style: GoogleFonts.raleway(
                                    fontSize: 10.sp,
                                    color: white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: white,
                          ),
                          onPressed: () {
                            // TODO: Implement delete payment method button functionality.
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                color: base,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Upcoming Tours',
                        style: GoogleFonts.raleway(
                            fontSize: 14.sp,
                            color: white,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: Colors.grey[600],
                        ),
                        title: Text(
                          'Tour to Pyramids',
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Text(
                          'July 1, 2023',
                          style: GoogleFonts.raleway(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[600],
                        ),
                        onTap: () {
                          // TODO: Implement trip details screen.
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.yellow.withOpacity(0.4)),
                    ),
                    child: Text(
                      'Log out',
                      style: GoogleFonts.raleway(
                          fontSize: 10.sp,
                          color: white,
                          fontWeight: FontWeight.w800),
                    ),
                    onPressed: () {
                      // TODO: Implement logout functionality.
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen2.routeName, (route) => false);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

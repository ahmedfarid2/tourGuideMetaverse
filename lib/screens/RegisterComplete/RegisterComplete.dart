import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_animations/im_animations.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/screens/toursim_page/tourism_page.dart';
import 'package:tour_guide_metaverse/shared/data_models/destination_model.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/CustomizedButton.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class RegisterComplete extends StatefulWidget {
  static const String routeName = "RegisterComplete";

  final Destination destination;

  RegisterComplete({Key? key, required this.destination}) : super(key: key);

  @override
  State<RegisterComplete> createState() => _RegisterCompleteState();
}

class _RegisterCompleteState extends State<RegisterComplete> {
  String codeValue = "";
  int tappedIndex = -1;
  bool isPressed = false;
  List<Destination> popular =
      destinations.where((element) => element.category == 'popular').toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: base,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: base,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.sp),
                      bottomLeft: Radius.circular(15.sp),
                    ),
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [Colors.transparent, base],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.darken,
                      child: Image.asset(
                        'assets/images/Elkarnak/elKarnak4.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 6.w,
                      bottom: 3.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register \nComplete!',
                          style: GoogleFonts.raleway(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          'You have successfully created \nyour account.',
                          style: GoogleFonts.raleway(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                      right: 5.w,
                      top: 5.h,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: white,
                          size: 8.sp,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'Luxor Egypt',
                          style: GoogleFonts.raleway(
                            fontSize: 6.sp,
                            color: white.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
            child: Column(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ColorSonar(
                          //contentAreaColor: Colors.yellow,
                          //innerWaveColor: Colors.yellow,
                          middleWaveColor: Colors.yellow.withOpacity(0.25),
                          outerWaveColor: Colors.yellow.withOpacity(0.15),
                          // wavesDisabled: true,
                          // waveMotion: WaveMotion.synced,
                          contentAreaRadius: 30.0.sp,
                          waveFall: 12.5.sp,
                          // waveMotionEffect: Curves.elasticIn,
                          waveMotion: WaveMotion.synced,
                          //duration: Duration(seconds: 3),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.yellow,
                                width: 0.5.w,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 42.0.sp,
                              backgroundImage:
                                  const AssetImage('assets/images/intro2.jpg'),
                              //مفروض هنا الاميج اللي اليوزر هيحطها
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Text(
                  'pepars',
                  // هنا اسمه
                  style: GoogleFonts.raleway(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomizedButton(
                  buttonText: "Explore Home",
                  buttonColor: yellow,
                  onPressed: () async {
                    Navigator.pushNamed(
                      context,
                      TourismPage.routeName,
                      arguments: TourismPage(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

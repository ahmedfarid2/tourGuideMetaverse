import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_guide_metaverse/screens/intro_app/second_intro.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class FirstIntro extends StatelessWidget {
  const FirstIntro({Key? key}) : super(key: key);
  static const String routeName = "first_intro_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/intro1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 1000,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 20, right: 20),
                child: Container(
                  width: 450,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Embark on an epic journey around the world!',
                        style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'ChatGPT as your trusty guide.',
                        style: GoogleFonts.raleway(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, bottom: 50, left: 20),
                child: SizedBox(
                  height: 45,
                  width: 80,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, SecondIntro.routeName, (route) => false);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.yellow.withOpacity(0.4)),
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 25,
                      color: base,
                      weight: 100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

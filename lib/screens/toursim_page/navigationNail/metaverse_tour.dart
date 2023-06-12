import 'package:flutter/material.dart';
import 'package:tour_guide_metaverse/screens/OculusConnectionScreen.dart';
import 'package:tour_guide_metaverse/screens/places_datails/PlaceDetails.dart';

class METAVERSE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 630,
          width: 300,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/images/meta1.jpeg',
                  height: 630,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                    child: Container(
                      width: 250,
                      child: const Text(
                        'Have a virtual tour inside the Metaverse with a tour guide.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, bottom: 30, left: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, PlaceDetailsScreen.routeName);
                      },
                      child: const Icon(Icons.arrow_forward),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange[900]),
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
          height: 630,
          width: 300,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/images/meta2.jpeg',
                  height: 630,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                    child: Container(
                      width: 250,
                      child: const Text(
                        'Have a virtual tour inside the Metaverse with a tour guide.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, bottom: 30, left: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, OculusConnectionScreen.routeName);
                      },
                      child: const Icon(Icons.arrow_forward),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange[900]),
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

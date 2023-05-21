import 'package:flutter/material.dart';
import 'package:tour_guide_metaverse/screens/tour_guide_details/tourGuideDetails.dart';
import 'package:tour_guide_metaverse/shared/data_models/destination_model.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class PlaceDetailsScreen extends StatefulWidget {
  static const String routeName = "places_details_page";
  final Destination destination;

  const PlaceDetailsScreen({Key? key, required this.destination})
      : super(key: key);

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  PageController pageController = PageController();
  int pageView = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.shade200,
      body: Container(
          decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      PageView(
                        controller: pageController,
                        onPageChanged: (value) {
                          setState(() {
                            pageView = value;
                          });
                        },
                        children: List.generate(
                          widget.destination.image!.length,
                          (index) => ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [Colors.transparent, Colors.black],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.darken,
                              child: Image.asset(
                                'assets/${widget.destination.image![index]}',
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      Column(
                        children: [
                          const Spacer(),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 100),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star_rounded,
                                              color: yellow,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '\$${widget.destination.rate!}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: white),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.destination.name!,
                                                  style: const TextStyle(
                                                      fontSize: 40,
                                                      color: white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    const Icon(
                                                      Icons.location_on,
                                                      color: white,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      widget.destination
                                                          .location!,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                  flex: 1,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (pageController.hasClients) {
                                              pageController.animateToPage(
                                                  pageView ==
                                                          widget
                                                                  .destination
                                                                  .image!
                                                                  .length -
                                                              1
                                                      ? 0
                                                      : pageView + 1,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            margin: const EdgeInsets.only(
                                                right: 10, bottom: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2, color: white),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    image: widget
                                                                    .destination
                                                                    .image!
                                                                    .length -
                                                                1 !=
                                                            pageView
                                                        ? AssetImage(
                                                            'assets/${widget.destination.image![pageView + 1]}')
                                                        : AssetImage(
                                                            'assets/${widget.destination.image![0]}'),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (pageController.hasClients) {
                                              pageController.animateToPage(
                                                  pageView ==
                                                          widget
                                                                  .destination
                                                                  .image!
                                                                  .length -
                                                              1
                                                      ? 0
                                                      : pageView + 1,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            margin: const EdgeInsets.only(
                                                right: 10, bottom: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2, color: white),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    image: widget
                                                                    .destination
                                                                    .image!
                                                                    .length -
                                                                1 !=
                                                            pageView
                                                        ? AssetImage(
                                                            'assets/${widget.destination.image![pageView + 1]}')
                                                        : AssetImage(
                                                            'assets/${widget.destination.image![0]}'),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (pageController.hasClients) {
                                              pageController.animateToPage(
                                                  pageView ==
                                                          widget
                                                                  .destination
                                                                  .image!
                                                                  .length -
                                                              1
                                                      ? 0
                                                      : pageView + 1,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            margin: const EdgeInsets.only(
                                                right: 10, bottom: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2, color: white),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    image: widget
                                                                    .destination
                                                                    .image!
                                                                    .length -
                                                                1 !=
                                                            pageView
                                                        ? AssetImage(
                                                            'assets/${widget.destination.image![pageView + 1]}')
                                                        : AssetImage(
                                                            'assets/${widget.destination.image![0]}'),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (pageController.hasClients) {
                                              pageController.animateToPage(
                                                  pageView ==
                                                          widget
                                                                  .destination
                                                                  .image!
                                                                  .length -
                                                              1
                                                      ? 0
                                                      : pageView + 1,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            margin: const EdgeInsets.only(
                                                right: 10, bottom: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2, color: white),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    image: widget
                                                                    .destination
                                                                    .image!
                                                                    .length -
                                                                1 !=
                                                            pageView
                                                        ? AssetImage(
                                                            'assets/${widget.destination.image![pageView + 1]}')
                                                        : AssetImage(
                                                            'assets/${widget.destination.image![0]}'),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (pageController.hasClients) {
                                              pageController.animateToPage(
                                                  pageView ==
                                                          widget
                                                                  .destination
                                                                  .image!
                                                                  .length -
                                                              1
                                                      ? 0
                                                      : pageView + 1,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            margin: const EdgeInsets.only(
                                                right: 10, bottom: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2, color: white),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    image: widget
                                                                    .destination
                                                                    .image!
                                                                    .length -
                                                                1 !=
                                                            pageView
                                                        ? AssetImage(
                                                            'assets/${widget.destination.image![pageView + 1]}')
                                                        : AssetImage(
                                                            'assets/${widget.destination.image![0]}'),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (pageController.hasClients) {
                                              pageController.animateToPage(
                                                  pageView ==
                                                          widget
                                                                  .destination
                                                                  .image!
                                                                  .length -
                                                              1
                                                      ? 0
                                                      : pageView + 1,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            margin: const EdgeInsets.only(
                                                right: 10, bottom: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2, color: white),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    image: widget
                                                                    .destination
                                                                    .image!
                                                                    .length -
                                                                1 !=
                                                            pageView
                                                        ? AssetImage(
                                                            'assets/${widget.destination.image![pageView + 1]}')
                                                        : AssetImage(
                                                            'assets/${widget.destination.image![0]}'),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: DefaultTabController(
                      length: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: const TabBar(
                              labelColor: Colors.blue,
                              unselectedLabelColor: Colors.black,
                              indicatorColor: Colors.blue,
                              indicatorSize: TabBarIndicatorSize.label,
                              tabs: [
                                Tab(
                                  text: 'History',
                                ),
                                Tab(
                                  text: 'Location',
                                ),
                                Tab(
                                  text: 'Review',
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SingleChildScrollView(
                                    child: Text(
                                      'The Karnak Temple, located in Luxor, Egypt, is one of the largest ancient Egyptian temple complexes. It was built around 2055 BC and expanded by pharaohs like Amenhotep III, Tutankhamun, and Ramses II. Karnak served as the religious and political center of ancient Egypt. During Akhenaten\'s reign, it faced neglect. Excavation and restoration efforts have preserved its magnificent ruins. The temple complex features impressive structures, including obelisks and grand halls. Karnak Temple attracts millions of visitors, showcasing the power and splendor of ancient Egyptian civilization. It reflects the devotion to the Theban Triad of Amun, Mut, and Khonsu. Karnak\'s history spans centuries, leaving a significant mark on Egypt\'s cultural heritage.',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 12,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                const Center(
                                  child: Text(
                                    'Location',
                                  ),
                                ),
                                Center(
                                  child: Text('Review'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )))
            ],
          )),
      extendBody: true,
      bottomNavigationBar: Container(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: '\$${widget.destination.price}',
                            style: const TextStyle(
                                color: blue,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                            text: ' / Person',
                            style: TextStyle(
                                fontSize: 14, color: black.withOpacity(0.6)))
                      ]))
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          TourGuideDetails.routeName,
                        );
                      },
                      child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: black,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.confirmation_number_outlined,
                                  color: white,
                                ),
                                SizedBox(width: 5),
                                Text('Book Ticket',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: white,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Container(
                height: 5,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    color: black, borderRadius: BorderRadius.circular(10)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

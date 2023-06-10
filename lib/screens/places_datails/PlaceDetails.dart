import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/screens/tourguide_list/tourguide_list.dart';
import 'package:tour_guide_metaverse/shared/data_models/Reviews.dart';
import 'package:tour_guide_metaverse/shared/data_models/destination_model.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final Destination destination;
  static const String routeName = "place_details_page";

  const PlaceDetailsScreen({Key? key, required this.destination})
      : super(key: key);

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  PageController pageController = PageController();
  int pageView = 0;
  int tappedIndex = -1;
  bool isPressed = false;
  double selectedRating = 0.0;

  List<Review> filteredReviews = [];

  @override
  void initState() {
    super.initState();
    filterReviews();
  }

  void filterReviews() {
    filteredReviews = reviews.where((review) {
      if (selectedRating == 0.0) {
        return true;
      } else {
        return review.rating == selectedRating;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Destination> popular =
        destinations.where((element) => element.category == 'popular').toList();
    return Scaffold(
      backgroundColor: base,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: base,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: base,
              leading: Padding(
                padding: EdgeInsets.only(
                  left: 1.w,
                  top: 3.h,
                ),
                child: IconButton(
                  onPressed: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   '/LoginScreen',
                    //   arguments: LoginScreen(destination: popular[0],),
                    // );
                  },
                  icon: Icon(
                    Icons.arrow_back_sharp,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 4.w,
                    top: 3.h,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isPressed = !isPressed;
                      });
                    },
                    icon: Icon(
                      isPressed ? Icons.bookmark : Icons.bookmark_border,
                      color: isPressed ? Colors.yellow : null,
                    ),
                  ),
                ),
              ],
              expandedHeight: MediaQuery.of(context).size.height * 0.6,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: base,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
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
                                  colors: [Colors.transparent, base],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.darken,
                              child: Image.asset(
                                'assets/${widget.destination.image![index]}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Spacer(),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 6.w,
                                        bottom: 1.h,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 15.w,
                                            height: 5.h,
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.star_rounded,
                                                    color: Colors.yellow,
                                                    size: 13.sp,
                                                  ),
                                                  Text(
                                                    '${widget.destination.rate!}',
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 12.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
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
                                                  Container(
                                                    width: 60.w,
                                                    child: Text(
                                                      widget.destination.name!,
                                                      style:
                                                          GoogleFonts.raleway(
                                                        fontSize: 30.sp,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
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
                                                        style:
                                                            GoogleFonts.raleway(
                                                          fontSize: 14,
                                                          color: white
                                                              .withOpacity(0.6),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
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
                                  Expanded(
                                    flex: 1,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          widget.destination.image!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              tappedIndex = index;
                                            });
                                            if (pageController.hasClients) {
                                              pageController.animateToPage(
                                                index,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.easeInOut,
                                              );
                                            }
                                          },
                                          child: Center(
                                            child: AnimatedContainer(
                                              height: 50,
                                              width: 50,
                                              margin: EdgeInsets.only(
                                                  right: 3.w, bottom: 10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: tappedIndex == index
                                                      ? Colors.yellow
                                                      : Colors.white,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/${widget.destination.image![index]}'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              transform: Matrix4.identity()
                                                ..scale(tappedIndex == index
                                                    ? 1.1
                                                    : 1.0),
                                            ),
                                          ),
                                        );
                                      },
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
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TabBar(
                          labelColor: yellow,
                          unselectedLabelColor: white,
                          indicatorColor: yellow,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 15.0,
                          ),
                          // Adjust the vertical padding here
                          tabs: [
                            Tab(
                              child: Text(
                                'History',
                                style: GoogleFonts.raleway(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Location',
                                style: GoogleFonts.raleway(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Review',
                                style: GoogleFonts.raleway(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 40,
                                  right: 20,
                                  top: 10,
                                ),
                                child: Text(
                                  '${widget.destination.description}',
                                  style: GoogleFonts.raleway(
                                    color: white.withOpacity(0.6),
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
                            SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 2.w,
                                  right: 2.w,
                                  top: 20,
                                  bottom: 20,
                                ),
                                child: Column(
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          FilterButton(
                                            rating: 0.0,
                                            isSelected: selectedRating == 0.0,
                                            onPressed: () {
                                              setState(() {
                                                selectedRating = 0.0;
                                                filterReviews();
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FilterButton(
                                            rating: 5.0,
                                            isSelected: selectedRating == 5.0,
                                            onPressed: () {
                                              setState(() {
                                                selectedRating = 5.0;
                                                filterReviews();
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FilterButton(
                                            rating: 4.0,
                                            isSelected: selectedRating == 4.0,
                                            onPressed: () {
                                              setState(() {
                                                selectedRating = 4.0;
                                                filterReviews();
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FilterButton(
                                            rating: 3.0,
                                            isSelected: selectedRating == 3.0,
                                            onPressed: () {
                                              setState(() {
                                                selectedRating = 3.0;
                                                filterReviews();
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FilterButton(
                                            rating: 2.0,
                                            isSelected: selectedRating == 2.0,
                                            onPressed: () {
                                              setState(() {
                                                selectedRating = 2.0;
                                                filterReviews();
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FilterButton(
                                            rating: 1.0,
                                            isSelected: selectedRating == 1.0,
                                            onPressed: () {
                                              setState(() {
                                                selectedRating = 1.0;
                                                filterReviews();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: filteredReviews.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage:
                                                filteredReviews[index]
                                                    .avatarImage,
                                          ),
                                          title: Text(
                                            filteredReviews[index].name,
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.w700,
                                              color: white,
                                            ),
                                          ),
                                          subtitle: Text(
                                            filteredReviews[index].comment,
                                            style: GoogleFonts.raleway(
                                              color: white.withOpacity(0.6),
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12,
                                            ),
                                          ),
                                          trailing: Container(
                                            width: 80.0,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color: Colors.yellow
                                                  .withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.star_rounded,
                                                    color: yellow,
                                                    size: 20.0,
                                                  ),
                                                  Text(
                                                    filteredReviews[index]
                                                        .rating
                                                        .toString(),
                                                    style: GoogleFonts.raleway(
                                                      color: white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
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
                ),
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          color: base,
          boxShadow: [
            BoxShadow(
              offset: Offset.zero,
              color: base.withOpacity(0.9),
              spreadRadius: 80,
              blurRadius: 100,
            )
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(5.w, 0, 6.w, 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '\$${widget.destination.price}',
                                style: GoogleFonts.raleway(
                                  color: yellow,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: ' / Person',
                                style: GoogleFonts.raleway(
                                  fontSize: 14,
                                  color: white.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          // Handle the tap event and navigate to the desired screen
                          Navigator.pushNamed(context, TourGuideList.routeName,
                              arguments: TourGuideList(
                                destination: popular[0],
                              ));
                        },
                        child: Container(
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: base,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Book Now',
                                  style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    color: base,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final double rating;
  final bool isSelected;
  final VoidCallback onPressed;

  const FilterButton({
    required this.rating,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 40.0,
      decoration: BoxDecoration(
        border: isSelected
            ? null
            : Border.all(
                width: 2,
                color: yellow.withOpacity(0.4),
              ),
        borderRadius: BorderRadius.circular(13),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: isSelected ? yellow.withOpacity(0.4) : base,
          onPrimary: isSelected ? white : base,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            const Icon(
              Icons.star_rounded,
              color: yellow,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              rating == 0 ? 'All' : rating.toString(),
              style: GoogleFonts.raleway(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_guide_metaverse/screens/places_datails/PlaceDetails.dart';
import 'package:tour_guide_metaverse/screens/tour_guide_details/details.dart';
import 'package:tour_guide_metaverse/shared/data_models/Reviews.dart';
import 'package:tour_guide_metaverse/shared/data_models/TourGuide.dart';
import 'package:tour_guide_metaverse/shared/data_models/destination_model.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class TourGuideList extends StatefulWidget {
  final Destination destination;

  const TourGuideList({Key? key, required this.destination}) : super(key: key);
  static const String routeName = "tour_guide_list_page";

  @override
  _TourGuideListState createState() => _TourGuideListState();
}

class _TourGuideListState extends State<TourGuideList> {
  late PageController _pageController;
  int _currentPage = 0;
  List<Review> filteredReviews = [];
  double selectedRating = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
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
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Destination> popular =
        destinations.where((element) => element.category == 'popular').toList();
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
                Navigator.pushNamed(
                  context,
                  PlaceDetailsScreen.routeName,
                  arguments: PlaceDetailsScreen(destination: popular[0]),
                );
              },
            ),
          ),
        ),
        backgroundColor: base,
        toolbarHeight: 10.h,
      ),
      body: DefaultTabController(
        length: 2, // Replace with the desired number of tabs
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 4.5.w,
                top: 1.0.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Find YourGuide",
                      style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 30)),
                  SizedBox(
                    height: 0.4.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: white,
                        size: 9.sp,
                      ),
                      SizedBox(
                        width: 0.5.w,
                      ),
                      Text('${widget.destination.location}',
                          style: GoogleFonts.raleway(
                              fontWeight: FontWeight.normal,
                              color: white.withOpacity(0.6),
                              fontSize: 9.sp)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TabBar(
                labelColor: yellow,
                unselectedLabelColor: white,
                indicatorColor: yellow,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.symmetric(
                  vertical: 3.w,
                  horizontal: 3.h,
                ),
                tabs: [
                  Tab(
                    child: Text(
                      'Overview',
                      style: GoogleFonts.raleway(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Reviews',
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
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dataList.length,
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return guideView(index);
                    },
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
                                const SizedBox(
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
                                const SizedBox(
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
                                const SizedBox(
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
                                const SizedBox(
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
                                const SizedBox(
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
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredReviews.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      filteredReviews[index].avatarImage,
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
                                    color: Colors.yellow.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
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
    );
  }

  Widget guideView(int index) {
    return guideCard(dataList[index]);
  }

  Widget guideCard(DataModel data) {
    return Container(
      width: 85.w,
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: data.imageName,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TourGuide_DetailsScreen(data: data),
                    ),
                  );
                },
                child: Opacity(
                  opacity: 0.6,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 8.h,
                      top: 2.h,
                      left: 2.w,
                      right: 2.w,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: AssetImage(data.imageName),
                          fit: BoxFit.fill,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 12.0.h,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    data.title,
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: .5.h,
                  ),
                  Container(
                    width: 15.0.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.yellow,
                            size: 8.0.sp,
                          ),
                          SizedBox(
                            width: .5.w,
                          ),
                          Text(
                            "\$${data.price}",
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: .5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '1,353',
                        style: GoogleFonts.raleway(
                          color: white.withOpacity(0.6),
                          fontWeight: FontWeight.normal,
                          fontSize: 8.sp,
                        ),
                      ),
                      SizedBox(
                        width: .5.w,
                      ),
                      Text(
                        'Reviews',
                        style: GoogleFonts.raleway(
                          color: white.withOpacity(0.6),
                          fontWeight: FontWeight.normal,
                          fontSize: 8.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
            const SizedBox(width: 5),
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

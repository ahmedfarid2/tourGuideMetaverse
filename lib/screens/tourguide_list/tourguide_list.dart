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

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
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
              icon: Icon(Icons.arrow_back),
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
                  Center(
                    child: Text(
                      'data',
                      style: TextStyle(color: white),
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

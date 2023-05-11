import 'dart:async';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide_metaverse/brand_colors.dart';
import 'package:tour_guide_metaverse/screens/search_page/searchPage.dart';
import 'package:tour_guide_metaverse/screens/tourVariables.dart';
import 'package:tour_guide_metaverse/shared/constants/constants.dart';
import 'package:tour_guide_metaverse/shared/data_models/directionDetails.dart';
import 'package:tour_guide_metaverse/shared/data_models/nearbyTour.dart';
import 'package:tour_guide_metaverse/shared/data_provider/appdata.dart';
import 'package:tour_guide_metaverse/shared/helpers/fireHelper.dart';
import 'package:tour_guide_metaverse/shared/helpers/helperMethods.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/BrandDivider.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/CollectPaymentDialog.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/NoDriverDialog.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/progressDialog.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/tourButton.dart';
import 'package:tour_guide_metaverse/shared/styles/styles.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String routeName = "main_page";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  double searchSheetHeight = (Platform.isIOS) ? 300.0 : 275.0;
  double rideDetailsSheetHeight = 0; //(Platform.isAndroid) ? 300.0 : 275.0;
  double reuestingSheetHeight = 0; //(Platform.isAndroid) ? 300.0 : 275.0;
  double tripSheetHeight = 0; //(Platform.isAndroid) ? 275.0 : 300.0;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late GoogleMapController mapController;

  double mapBottomPadding = 0;

  List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};

  BitmapDescriptor? nearbyIcon;

  late Position currentPosition;

  DirectionDetails? tripDirectionDetails;

  String appState = 'NORMAL';

  bool drawerCanopen = true;

  DatabaseReference? tourRef;

  StreamSubscription<DatabaseEvent>? rideSubscription;

  List<NearbyTour>? availableTours;

  bool nearbyToursKeysLoaded = false;

  bool isRequestingLocationDetails = false;

  void setupPositionLocator() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    print(position);
    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = CameraPosition(target: pos, zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
    String address =
        await HelperMethods.findCordinateAddress(position, context);
    print(address);
    startGeofireListener();
  }

  void showDetailSheet() async {
    await getDirection();

    setState(() {
      searchSheetHeight = 0;
      rideDetailsSheetHeight = (Platform.isAndroid) ? 235.0 : 260.0; //235 : 260
      mapBottomPadding = (Platform.isAndroid) ? 235.0 : 260.0; // 235 : 260

      drawerCanopen = false;
    });
  }

  void showRequestingSheet() {
    setState(() {
      rideDetailsSheetHeight = 0;
      reuestingSheetHeight = (Platform.isAndroid) ? 195.0 : 220.0;
      mapBottomPadding = (Platform.isAndroid) ? 195.0 : 220.0; // 195 : 220

      drawerCanopen = true;

      createTourRequest();
    });
  }

  showTripSheet() {
    setState(() {
      reuestingSheetHeight = 0;
      tripSheetHeight = (Platform.isAndroid) ? 275 : 300;
      mapBottomPadding = (Platform.isAndroid) ? 280 : 270;
    });
  }

  void createMarker() {
    if (nearbyIcon == null) {
      ImageConfiguration imageConfiguration = createLocalImageConfiguration(
        context,
        size: Size(
          2,
          2,
        ),
      );
      BitmapDescriptor.fromAssetImage(
        imageConfiguration,
        (Platform.isIOS)
            ? 'assets/images/car_ios.png'
            : 'assets/images/car_android.png',
      ).then((icon) {
        nearbyIcon = icon;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HelperMethods.getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    createMarker();

    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        width: 250.0,
        color: Colors.white,
        child: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              Container(
                color: Colors.white,
                height: 160.0,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/user_icon.png",
                        height: 60.0,
                        width: 60.0,
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Ahmed Farid",
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: "Brand-Bold"),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text("View profile"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const BrandDivider(),
              const SizedBox(
                height: 10.0,
              ),
              ListTile(
                leading: const Icon(Icons.card_giftcard),
                title: Text(
                  'Free Tour',
                  style: kDrawerItemtyle,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.credit_card),
                title: Text(
                  'Payments',
                  style: kDrawerItemtyle,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: Text(
                  'Tour History',
                  style: kDrawerItemtyle,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.contact_support_outlined),
                title: Text(
                  'Support',
                  style: kDrawerItemtyle,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(
                  'About',
                  style: kDrawerItemtyle,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapBottomPadding),
            initialCameraPosition: googlePlex,
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: true,
            polylines: _polylines,
            markers: _markers,
            circles: _circles,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              mapController = controller;
              setState(() {
                mapBottomPadding = (Platform.isAndroid) ? 275.0 : 300.0;
              });
              setupPositionLocator();
            },
          ),

          ///menu button
          Positioned(
            top: 44.0,
            left: 20.0,
            child: GestureDetector(
              onTap: () {
                if (drawerCanopen) {
                  scaffoldKey.currentState?.openDrawer();
                } else {
                  resetApp();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20.0,
                  child: Icon(
                    (drawerCanopen) ? Icons.menu : Icons.arrow_back,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),

          ///search sheet
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedSize(
              vsync: this,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeIn,
              child: Container(
                height: searchSheetHeight,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Text(
                        "Nice to see you!",
                        style: TextStyle(fontSize: 10.0),
                      ),
                      const Text(
                        "Get your Tour?",
                        style:
                            TextStyle(fontSize: 18.0, fontFamily: "Brand-Bold"),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                          var response = await Navigator.pushNamed(
                              context, SearchPage.routeName);
                          if (response == 'getDirection') {
                            showDetailSheet();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.search,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Search Destinition"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.home_outlined,
                            color: BrandColors.colorDimText,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (Provider.of<AppData>(context)
                                              .pickupAddress !=
                                          null)
                                      ? Provider.of<AppData>(context)
                                          .pickupAddress!
                                          .placeName!
                                      : 'Add Home',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                const Text(
                                  "Your residential address",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: BrandColors.colorDimText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const BrandDivider(),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.work_outline,
                            color: BrandColors.colorDimText,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Add Work",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Your office address",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: BrandColors.colorDimText,
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

          ///ride details sheet
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedSize(
              vsync: this,
              duration: const Duration(milliseconds: 150),
              child: Container(
                height: rideDetailsSheetHeight,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: BrandColors.colorAccent1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/tourguide.png',
                                height: 70.0,
                                width: 70.0,
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tour Guide',
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: 'Brand-Bold'),
                                  ),
                                  Text(
                                    (tripDirectionDetails != null)
                                        ? tripDirectionDetails!.distanceText!
                                        : '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: BrandColors.colorTextLight),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Text(
                                (tripDirectionDetails != null)
                                    ? '\$${HelperMethods.estimateFares(tripDirectionDetails!)}'
                                    : '',
                                style: const TextStyle(
                                    fontSize: 18, fontFamily: 'Brand-Bold'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.money_rounded,
                              size: 25,
                              color: BrandColors.colorTextLight,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              'Cash',
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: BrandColors.colorTextLight,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TourButtton(
                            title: 'Request Tour Guide',
                            color: BrandColors.colorGreen,
                            onPressed: () {
                              setState(() {
                                appState = 'REQUESTING';
                              });
                              showRequestingSheet();

                              availableTours = FireHelper.nearbyTourList;

                              findTour();
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          ///requesting tour sheet
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedSize(
              vsync: this,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeIn,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ),
                    ),
                  ],
                ),
                height: reuestingSheetHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextLiquidFill(
                          text: 'Requesting A Tour...',
                          waveColor: BrandColors.colorTextSemiLight,
                          boxBackgroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 22.0,
                            fontFamily: 'Brand-Bold',
                          ),
                          boxHeight: 40.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          cancelRequest();
                          resetApp();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                                width: 1.0,
                                color: BrandColors.colorLightGrayFair),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: const Text(
                          'Cancel Tour',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          ///Trip sheet
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedSize(
              vsync: this,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeIn,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ),
                    ),
                  ],
                ),
                height: tripSheetHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tripStatusDisplay,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Brand-Bold',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BrandDivider(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        tourInfoDetails,
                        style: TextStyle(color: BrandColors.colorTextLight),
                      ),
                      Text(
                        tourFullName,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BrandDivider(),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular((25))),
                                  border: Border.all(
                                    width: 1.0,
                                    color: BrandColors.colorTextLight,
                                  ),
                                ),
                                child: Icon(Icons.call),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Call'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular((25))),
                                  border: Border.all(
                                    width: 1.0,
                                    color: BrandColors.colorTextLight,
                                  ),
                                ),
                                child: Icon(Icons.list),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Details'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular((25))),
                                  border: Border.all(
                                    width: 1.0,
                                    color: BrandColors.colorTextLight,
                                  ),
                                ),
                                child: Icon(Icons.clear_outlined),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Cancel'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getDirection() async {
    var pickup = Provider.of<AppData>(context, listen: false).pickupAddress;
    var destination =
        Provider.of<AppData>(context, listen: false).destinationAddress;

    var pickupLatLng = LatLng(pickup!.latitude!, pickup.longitude!);
    var destinationLatLng =
        LatLng(destination!.latitude!, destination.longitude!);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            const ProgressDialog(status: 'Please wait...'));

    var thisDetails = await HelperMethods.getDirectionDetails(
        pickupLatLng, destinationLatLng);

    setState(() {
      tripDirectionDetails = thisDetails!;
    });

    Navigator.pop(context);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> results =
        polylinePoints.decodePolyline(thisDetails!.encodedPoints!);

    polylineCoordinates.clear();
    if (results.isNotEmpty) {
      //loop through all  pointLatlng points and convert them
      //to a list of Latlng, required by he polyline

      results.forEach((PointLatLng points) {
        polylineCoordinates.add(LatLng(points.latitude, points.longitude));
      });

      _polylines.clear();
      setState(() {
        Polyline polyline = Polyline(
          polylineId: const PolylineId('polyid'),
          color: const Color.fromARGB(255, 95, 109, 237),
          points: polylineCoordinates,
          jointType: JointType.round,
          width: 4,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true,
        );

        _polylines.add(polyline);
      });
      //make polyline to fit into the map
      LatLngBounds bounds;
      if (pickupLatLng.latitude > destinationLatLng.latitude &&
          pickupLatLng.longitude > destinationLatLng.longitude) {
        bounds =
            LatLngBounds(southwest: destinationLatLng, northeast: pickupLatLng);
      } else if (pickupLatLng.longitude > destinationLatLng.longitude) {
        bounds = LatLngBounds(
          southwest: LatLng(pickupLatLng.latitude, destinationLatLng.longitude),
          northeast: LatLng(destinationLatLng.latitude, pickupLatLng.longitude),
        );
      } else if (pickupLatLng.latitude > destinationLatLng.latitude) {
        bounds = LatLngBounds(
          southwest: LatLng(destinationLatLng.latitude, pickupLatLng.longitude),
          northeast: LatLng(pickupLatLng.latitude, destinationLatLng.longitude),
        );
      } else {
        bounds =
            LatLngBounds(southwest: pickupLatLng, northeast: destinationLatLng);
      }
      mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));

      Marker pickupMarker = Marker(
        markerId: const MarkerId('pickup'),
        position: pickupLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: pickup.placeName, snippet: 'My Location'),
      );

      Marker destinationMarker = Marker(
        markerId: const MarkerId('destination'),
        position: destinationLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow:
            InfoWindow(title: destination.placeName, snippet: 'Destination'),
      );

      setState(() {
        _markers.add(pickupMarker);
        _markers.add(destinationMarker);
      });

      Circle pickupCircle = Circle(
        circleId: const CircleId('pickup'),
        strokeColor: Colors.green,
        strokeWidth: 3,
        radius: 12,
        center: pickupLatLng,
        fillColor: BrandColors.colorGreen,
      );

      Circle destinationCircle = Circle(
        circleId: const CircleId('destination'),
        strokeColor: BrandColors.colorAccentPurple,
        strokeWidth: 3,
        radius: 12,
        center: destinationLatLng,
        fillColor: BrandColors.colorAccentPurple,
      );

      setState(() {
        _circles.add(pickupCircle);
        _circles.add(destinationCircle);
      });
    }
  }

  void startGeofireListener() {
    Geofire.initialize('toursAvaiable');
    // 20 is => 20 km the range
    Geofire.queryAtLocation(
            currentPosition.latitude, currentPosition.longitude, 20)
        ?.listen((map) {
      print(map);
      if (map != null) {
        var callBack = map['callBack'];

        //latitude will be retrieved from map['latitude']
        //longitude will be retrieved from map['longitude']

        switch (callBack) {
          case Geofire.onKeyEntered:
            NearbyTour nearbyTour = NearbyTour();
            nearbyTour.key = map['key'];
            nearbyTour.latitude = map['latitude'];
            nearbyTour.longitude = map['longitude'];
            FireHelper.nearbyTourList.add(nearbyTour);

            if (nearbyToursKeysLoaded) {
              updateTourOnMap();
            }
            break;

          case Geofire.onKeyExited:
            FireHelper.removeFromList(map['key']);
            updateTourOnMap();
            break;

          case Geofire.onKeyMoved:
            // Update your key's location

            NearbyTour nearbyTour = NearbyTour();
            nearbyTour.key = map['key'];
            nearbyTour.latitude = map['latitude'];
            nearbyTour.longitude = map['longitude'];

            FireHelper.updateNearbyLocation(nearbyTour);
            updateTourOnMap();
            break;

          case Geofire.onGeoQueryReady:
            // All Intial Data is loaded
            // print('firehelper length: ${FireHelper.nearbyTourList.length}');
            nearbyToursKeysLoaded = true;
            updateTourOnMap();
            break;
        }
      }
    });
  }

  void updateTourOnMap() {
    setState(() {
      _markers.clear();
    });

    Set<Marker> tempMarkers = Set<Marker>();
    for (NearbyTour nearbyTour in FireHelper.nearbyTourList) {
      LatLng tourPosition = LatLng(nearbyTour.latitude!, nearbyTour.longitude!);

      Marker thisMarker = Marker(
        markerId: MarkerId('tour${nearbyTour.key}'),
        position: tourPosition,
        // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        icon: nearbyIcon!,
        rotation: HelperMethods.generateRandomNumber(360),
      );

      tempMarkers.add(thisMarker);
    }
    setState(() {
      _markers = tempMarkers;
    });
  }

  void createTourRequest() {
    tourRef = FirebaseDatabase.instance.ref().child('tourRequest').push();
    var pickup = Provider.of<AppData>(context, listen: false).pickupAddress;
    var destination =
        Provider.of<AppData>(context, listen: false).destinationAddress;

    Map pickupMap = {
      'latitude': pickup?.latitude.toString(),
      'longitude': pickup?.longitude.toString(),
    };

    Map destinationMap = {
      'latitude': destination?.latitude.toString(),
      'longitude': destination?.longitude.toString(),
    };

    Map tourMap = {
      'created_at': DateTime.now().toString(),
      'tour_guide_name': currentUserInfo?.fullName,
      'tour_guide_phone': currentUserInfo?.phone,
      'pickup_address': pickup?.placeName,
      'destination_address': destination?.placeName,
      'location': pickupMap,
      'destination': destinationMap,
      'payment_method': 'card',
      'tour_guide_id': 'waiting',
    };

    tourRef?.set(tourMap);

    rideSubscription = tourRef!.onValue.listen((event) async {
      final data = event.snapshot.value as Map;
      // check for null snapshot
      if (event.snapshot.value == null) {
        return;
      }

      //get tour details
      if (data['tour_info'] != null) {
        setState(() {
          tourInfoDetails = data['tour_info'].toString();
        });
      }

      //get tour name
      if (data['tour_guide_name'] != null) {
        setState(() {
          tourFullName = data['tour_guide_name'].toString();
        });
      }

      //get tour phone number
      if (data['tour_guide_phone'] != null) {
        setState(() {
          tourPhoneNumber = data['tour_guide_phone'].toString();
        });
      }

      // get and use tour location
      if (data['tour_guide_location'] != null) {
        double tourLat =
            double.parse(data['tour_guide_location']['latitude'].toString());
        double tourLng =
            double.parse(data['tour_guide_location']['longitude'].toString());

        LatLng tourLocation = LatLng(tourLat, tourLng);

        if (status == 'accepted') {
          updateToPickup(tourLocation);
        } else if (status == 'ontrip') {
          updateToDestination(tourLocation);
        } else if (status == 'arrived') {
          setState(() {
            tripStatusDisplay = 'Tour Guide has Arrived';
          });
        }
      }

      if (data['status'] != null) {
        status = data['status'].toString();
      }

      if (status == 'accepted') {
        showTripSheet();
        Geofire.stopListener();
        removeGeofireMarkers();
      }

      if (status == 'ended') {
        if (data['fares'] != null) {
          int fares = int.parse(data['fares'].toString());

          var response = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => CollectPayment(
              paymentMethod: 'cash',
              fares: fares,
            ),
          );

          if (response == 'close') {
            tourRef?.onDisconnect();
            tourRef = null;
            rideSubscription?.cancel();
            rideSubscription = null;
            resetApp();
          }
        }
      }
    });
  }

  void removeGeofireMarkers() {
    setState(() {
      _markers.removeWhere((m) => m.markerId.value.contains('tour'));
    });
  }

  void updateToPickup(LatLng tourLocation) async {
    if (!isRequestingLocationDetails) {
      isRequestingLocationDetails = true;
      var positionLatLng =
          LatLng(currentPosition.latitude, currentPosition.longitude);

      var thisDetails =
          await HelperMethods.getDirectionDetails(tourLocation, positionLatLng);

      if (thisDetails == null) {
        return;
      }

      setState(() {
        tripStatusDisplay =
            'Tour Guide is Arriving - ${thisDetails.durtionText}';
      });

      isRequestingLocationDetails = false;
    }
  }

  void updateToDestination(LatLng tourLocation) async {
    if (!isRequestingLocationDetails) {
      isRequestingLocationDetails = true;

      var destination =
          Provider.of<AppData>(context, listen: false).destinationAddress;

      var destinationLatLng =
          LatLng(destination!.latitude!, destination.longitude!);

      var thisDetails = await HelperMethods.getDirectionDetails(
          tourLocation, destinationLatLng);

      if (thisDetails == null) {
        return;
      }

      setState(() {
        tripStatusDisplay =
            'Driving to Destination - ${thisDetails.durtionText}';
      });

      isRequestingLocationDetails = false;
    }
  }

  void cancelRequest() {
    tourRef?.remove();
    setState(() {
      appState = 'NORMAL';
    });
  }

  resetApp() {
    setState(() {
      polylineCoordinates.clear();
      _polylines.clear();
      _markers.clear();
      _circles.clear();
      rideDetailsSheetHeight = 0;
      reuestingSheetHeight = 0;
      tripSheetHeight = 0;
      searchSheetHeight = (Platform.isAndroid) ? 275.0 : 300.0;
      mapBottomPadding = (Platform.isAndroid) ? 275.0 : 300.0;
      drawerCanopen = true;

      status = '';
      tourFullName = '';
      tourPhoneNumber = '';
      tourInfoDetails = '';
      tripStatusDisplay = 'Tour Guide is Arriving';
    });
    setupPositionLocator();
  }

  void noTourFound() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => NoDriverDialog(),
    );
  }

  void findTour() {
    if (availableTours?.length == 0) {
      cancelRequest();
      resetApp();
      noTourFound();
      // no Tour
      return;
    }
    var tour = availableTours![0];

    notifyTour(tour);

    availableTours?.removeAt(0);

    print(tour.key);
  }

  void notifyTour(NearbyTour tour) {
    DatabaseReference tourTripRef =
        FirebaseDatabase.instance.ref().child('tourGuides/${tour.key}/newtrip');
    tourTripRef.set(tourRef?.key);

    // get and notify Tour guide using token
    DatabaseReference tokenRef =
        FirebaseDatabase.instance.ref().child('tourGuides/${tour.key}/token');
    tokenRef.once().then((DatabaseEvent databaseEvent) {
      if (databaseEvent.snapshot.value != null) {
        String token = databaseEvent.snapshot.value.toString();
        //send notification to selected tour
        HelperMethods.sendNotification(token, context, tourRef!.key!);
      } else {
        return;
      }

      const oneSecTick = Duration(seconds: 1);

      var timer = Timer.periodic(oneSecTick, (timer) {
        // stop timer when tour request is cancelled
        if (appState != 'REQUESTING') {
          tourTripRef.set('cancelled');
          tourTripRef.onDisconnect();
          timer.cancel();
          tourRequestTimeout = 30;
        }

        tourRequestTimeout--;

        // a value event listener for tour accepting tour trip request
        tourTripRef.onValue.listen((event) {
          // confirm that tour has clicked accepted for new trip request
          if (event.snapshot.value.toString() == 'accepted') {
            tourTripRef.onDisconnect();
            timer.cancel();
            tourRequestTimeout = 30;
          }
        });

        if (tourRequestTimeout == 0) {
          //informs tour that ride has timeout
          tourTripRef.set('timeout');
          tourTripRef.onDisconnect();
          tourRequestTimeout = 30;
          timer.cancel();

          // select the next closest tour
          findTour();
        }
      });
    });
  }
}

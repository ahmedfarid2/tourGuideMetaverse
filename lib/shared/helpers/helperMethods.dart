import 'dart:convert';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide_metaverse/shared/constants/constants.dart';
import 'package:tour_guide_metaverse/shared/data_models/address.dart';
import 'package:tour_guide_metaverse/shared/data_models/directionDetails.dart';
import 'package:tour_guide_metaverse/shared/data_models/history.dart';
import 'package:tour_guide_metaverse/shared/data_provider/appdata.dart';
import 'package:tour_guide_metaverse/shared/helpers/requesthelper.dart';

import '../data_models/user.dart';

class HelperMethods {
  static void getCurrentUserInfo() async {
    currentFirebaseUser = await FirebaseAuth.instance.currentUser!;
    String? userid = currentFirebaseUser?.uid;

    DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child('users/$userid');

    userRef.once().then((DatabaseEvent databaseEvent) {
      if (databaseEvent.snapshot.value != null) {
        currentUserInfo = Users.fromSnapshot(databaseEvent);
        // print('my name is ${currentUserInfo?.fullName}');
      }
    });
  }

  static Future<String> findCordinateAddress(Position position, context) async {
    String placeAddress = '';
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return placeAddress;
    }
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey';
    var response = await RequestHelper.getRequest(url);
    if (response != 'failed') {
      placeAddress = response['results'][0]['formatted_address'];
      Address pickupAddress = Address();
      pickupAddress.latitude = position.latitude;
      pickupAddress.longitude = position.longitude;
      pickupAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickupAddress(pickupAddress);
    }
    return placeAddress;
  }

  static Future<DirectionDetails?> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=$mapKey';

    var response = await RequestHelper.getRequest(url);

    if (response == 'failed') {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.distanceText =
        response['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        response['routes'][0]['legs'][0]['distance']['value'];

    directionDetails.durtionText =
        response['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.durtionValue =
        response['routes'][0]['legs'][0]['duration']['value'];

    directionDetails.encodedPoints =
        response['routes'][0]['overview_polyline']['points'];

    return directionDetails;
  }

  static int estimateFares(DirectionDetails details) {
    //per km = 0.3$
    //per minute = 0.5$
    //per fare = 3.0$

    double baseFare = 3.0;
    double distanceFare = (details.distanceValue! / 1000) * 0.3;
    double timeFare = (details.durtionValue! / 60) * 0.2;

    double totalFare = baseFare + distanceFare + timeFare;

    return totalFare.truncate();
  }

  static double generateRandomNumber(int max) {
    var randomGenerator = Random();
    int radInt = randomGenerator.nextInt(max);

    return radInt.toDouble();
  }

  static sendNotification(String token, context, String ride_id) async {
    var destination = Provider.of<AppData>(
      context,
      listen: false,
    ).destinationAddress;

    Map<String, String> headerMap = {
      'Content-Type': 'application/json',
      'Authorization': serverKey,
    };

    Map notificationMap = {
      'title': 'NEW TRIP REQUEST',
      'body': 'Destination, ${destination?.placeName}',
    };

    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'ride_id': ride_id,
    };

    Map bodyMap = {
      'notification': notificationMap,
      'priority': 'high',
      'data': dataMap,
      'to': token,
    };

    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var responce = await http.post(
      url,
      headers: headerMap,
      body: json.encode(bodyMap),
    );

    print(responce.body);
  }

  static void getHistoryInfo(context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DatabaseReference historyRef = FirebaseDatabase.instance
          .ref()
          .child('users/${currentUser.uid}/history');

      historyRef.once().then((DatabaseEvent databaseEvent) {
        if (databaseEvent.snapshot.value != null) {
          final data = databaseEvent.snapshot.value as Map;
          List<String> tripHistoryKeys = [];
          data.forEach((key, value) {
            tripHistoryKeys.add(key);
          });
          // update trip keys to data provider
          Provider.of<AppData>(context, listen: false)
              .updateTripKeys(tripHistoryKeys);

          getHistoryData(context);
        }
      });
    } else {
      print('Current user is null');
    }
  }

  static void getHistoryData(context) {
    final List<String> keys =
        Provider.of<AppData>(context, listen: false).tripHistoryKeys;
    final DatabaseReference historyRef = FirebaseDatabase.instance.ref();

    for (String key in keys) {
      DatabaseReference tripRef = historyRef.child('tourRequest/$key');
      tripRef.once().then((DatabaseEvent databaseEvent) {
        if (databaseEvent.snapshot.value != null) {
          var history = History.fromSnapshot(databaseEvent);
          Provider.of<AppData>(context, listen: false)
              .updateTripHistory(history);
          print(history.pickup);
        }
      });
    }
  }

  static String formatMyDate(String datestring) {
    DateTime thisDate = DateTime.parse(datestring);
    String formattedDate =
        '${DateFormat.MMMd().format(thisDate)}, ${DateFormat.y().format(thisDate)} - ${DateFormat.jm().format(thisDate)}';

    return formattedDate;
  }
}

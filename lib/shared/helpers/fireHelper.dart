import 'package:tour_guide_metaverse/shared/data_models/nearbyTour.dart';

class FireHelper {
  static List<NearbyTour> nearbyTourList = [];

  static void removeFromList(String key) {
    int index = nearbyTourList.indexWhere((element) => element.key == key);
    nearbyTourList.removeAt(index);
  }

  static void updateNearbyLocation(NearbyTour nearbyTour) {
    int index =
        nearbyTourList.indexWhere((element) => element.key == nearbyTour.key);
    nearbyTourList[index].latitude = nearbyTour.latitude;
    nearbyTourList[index].longitude = nearbyTour.longitude;
  }
}

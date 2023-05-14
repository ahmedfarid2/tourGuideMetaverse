import 'package:flutter/cupertino.dart';
import 'package:tour_guide_metaverse/shared/data_models/address.dart';
import 'package:tour_guide_metaverse/shared/data_models/history.dart';

class AppData extends ChangeNotifier {
  Address? pickupAddress;
  Address? destinationAddress;
  List<String> tripHistoryKeys = [];
  List<History> tripHistory = [];

  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }

  void updateDestinationAddress(Address destination) {
    destinationAddress = destination;
    notifyListeners();
  }

  void updateTripKeys(List<String> newKeys) {
    tripHistoryKeys = newKeys;
    notifyListeners();
  }

  void updateTripHistory(History historyItem) {
    tripHistory.add(historyItem);
    notifyListeners();
  }
}

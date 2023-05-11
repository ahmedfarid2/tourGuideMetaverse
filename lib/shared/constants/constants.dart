import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data_models/user.dart';

String serverKey =
    'key=AAAAUFTzURs:APA91bFulxsT_v-t9PUIb_uk4p-sZrWPVbHkJV3Dc9GhpfgxdikhYwyHszuwCZJSPN2J1ZnzWmRbm-19IjvxZ_VNxzW_q5L59YNGI1DeSXrCtaC8PfbfXBgaEzgkgG_H6OiooOdgCLr3';

String mapKey = "AIzaSyB-k3qBpiyV6iTRBvC82-zra7hc5j2Y-r0";

String mapKeyIos = "AIzaSyBOUVEJVt2Q4jKdcVLTmaGeq257APZfqS8";

final CameraPosition googlePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

User? currentFirebaseUser;

Users? currentUserInfo;

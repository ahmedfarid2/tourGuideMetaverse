import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide_metaverse/brand_colors.dart';
import 'package:tour_guide_metaverse/shared/constants/constants.dart';
import 'package:tour_guide_metaverse/shared/data_models/address.dart';
import 'package:tour_guide_metaverse/shared/data_models/prediction.dart';
import 'package:tour_guide_metaverse/shared/data_provider/appdata.dart';
import 'package:tour_guide_metaverse/shared/helpers/requesthelper.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/progressDialog.dart';

class PredictionTitle extends StatelessWidget {
  const PredictionTitle({
    super.key,
    required this.prediction,
  });

  final Prediction prediction;

  void getPlaceDetails(String placeID, context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const ProgressDialog(
        status: 'Please wait...',
      ),
    );

    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$mapKey';
    var response = await RequestHelper.getRequest(url);

    Navigator.pop(context);

    if (response == 'failed') {
      return;
    }
    if (response['status'] == 'OK') {
      Address thisPlace = Address();
      thisPlace.placeName = response['result']['name'];
      thisPlace.placeId = placeID;
      thisPlace.latitude = response['result']['geometry']['location']['lat'];
      thisPlace.longitude = response['result']['geometry']['location']['lng'];

      Provider.of<AppData>(context, listen: false)
          .updateDestinationAddress(thisPlace);
      Navigator.pop(context, 'getDirection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        getPlaceDetails(prediction.placeId, context);
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      child: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
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
                        prediction.mainText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 16.0, color: BrandColors.colorTextDark),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        prediction.secondaryText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 12.0, color: BrandColors.colorDimText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}

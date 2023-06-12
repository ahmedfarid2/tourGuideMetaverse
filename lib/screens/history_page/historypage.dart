import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide_metaverse/brand_colors.dart';
import 'package:tour_guide_metaverse/shared/data_provider/appdata.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/BrandDivider.dart';
import 'package:tour_guide_metaverse/shared/reusable_components/HistoryTile.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);
  static const String routeName = "tour_history";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tour History',
        ),
        backgroundColor: BrandColors.colorPrimary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return HistoryTile(
            history: Provider.of<AppData>(context).tripHistory[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const BrandDivider(),
        itemCount: Provider.of<AppData>(context).tripHistory.length,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }
}

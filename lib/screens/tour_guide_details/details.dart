import 'package:flutter/material.dart';
import 'package:tour_guide_metaverse/shared/data_models/TourGuide.dart';

class TourGuide_DetailsScreen extends StatefulWidget {
  final DataModel data;

  const TourGuide_DetailsScreen({Key? key, required this.data})
      : super(key: key);

  @override
  _TourGuide_DetailsScreenState createState() =>
      _TourGuide_DetailsScreenState();
}

class _TourGuide_DetailsScreenState extends State<TourGuide_DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black54),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                widget.data.title,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Hero(
                    tag: widget.data.imageName,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: AssetImage(
                                widget.data.imageName,
                              ),
                              fit: BoxFit.fill),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 4,
                                color: Colors.black26)
                          ]),
                    ),
                  ),
                )),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Price \$${widget.data.price}",
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

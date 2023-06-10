class DataModel {
  final String title;
  final String imageName;
  final double price;
  DataModel(
    this.title,
    this.imageName,
    this.price,
  );
}

List<DataModel> dataList = [
  DataModel("Eman pe-pars", "assets/images/TourGuide/guide1.jpg", 300.8),
  DataModel("Heba El-khateeb", "assets/images/TourGuide/guide4.jpg", 136.7),
  DataModel("Rana Watany", "assets/images/TourGuide/guide2.jpg", 245.2),
  DataModel("Shimaa Ezzat", "assets/images/TourGuide/guide3.jpg", 700),
  DataModel("Donya Helmy", "assets/images/TourGuide/guide4.jpg", 400),
  DataModel("Ahmed Ebrhim", "assets/images/TourGuide/guide5.jpg", 136.7),
  DataModel("Ahmed Farid", "assets/images/TourGuide/guide6.jpg", 136.7),
];
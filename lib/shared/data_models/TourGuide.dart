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
  DataModel("Eman pe-pars", "assets/images/tourguide/guide1.jpg", 300.8),
  DataModel("Heba El-khateeb", "assets/images/tourguide/guide4.jpg", 136.7),
  DataModel("Rana Watany", "assets/images/tourguide/guide2.jpg", 245.2),
  DataModel("Shimaa Ezzat", "assets/images/tourguide/guide3.jpg", 700),
  DataModel("Ahmed Ebrhim", "assets/images/tourguide/guide5.jpg", 136.7),
  DataModel("Ahmed Farid", "assets/images/tourguide/guide6.jpg", 2000.7),
];

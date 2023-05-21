import 'dart:math';

Random random = Random();

class Destination {
  final int? id, price, review;
  final List<String>? image;
  final String? name, description, category, location;
  final double? rate;

  Destination(
      {this.name,
      this.price,
      this.id,
      this.category,
      this.description,
      this.review,
      this.image,
      this.rate,
      this.location});
}

List<Destination> destinations = [
  Destination(
      id: 2,
      name: "El Karnak",
      category: 'popular',
      image: [
        "images/Elkarnak/elKarnak1.jpg",
        "images/Elkarnak/elKarnak5.jpg",
        "images/Elkarnak/elKarnak2.jpg",
        "images/Elkarnak/elKarnak3.jpg",
      ],
      location: "Luxor, Egypt",
      review: random.nextInt(300) + 25,
      price: random.nextInt(95) + 23,
      rate: 4.6),
];

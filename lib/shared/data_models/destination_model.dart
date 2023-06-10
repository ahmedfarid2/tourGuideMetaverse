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
      name: "El-Karnak Temple",
      category: 'popular',
      image: [
        "images/Elkarnak/elKarnak1.jpg",
        "images/Elkarnak/elKarnak2.jpg",
        "images/Elkarnak/elKarnak3.jpg",
        "images/Elkarnak/elKarnak4.jpg",
        "images/Elkarnak/elKarnak5.jpg",
      ],
      location: "Luxor, Egypt",
      review: random.nextInt(300) + 25,
      price: 107,
      description:
          'The Karnak Temple, located in Luxor, Egypt, is one of the largest ancient Egyptian temple complexes. It was built around 2055 BC and expanded by pharaohs like Amenhotep III, Tutankhamun, and Ramses II. Karnak served as the religious and political center of ancient Egypt. During Akhenaten\'s reign, it faced neglect. Excavation and restoration efforts have preserved its magnificent ruins. The temple complex features impressive structures, including obelisks and grand halls. Karnak Temple attracts millions of visitors, showcasing the power and splendor of ancient Egyptian civilization. It reflects the devotion to the Theban Triad of Amun, Mut, and Khonsu. Karnak\'s history spans centuries, leaving a significant mark on Egypt\'s cultural heritage.',
      rate: 4.9),
];
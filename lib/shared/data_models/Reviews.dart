import 'package:flutter/material.dart';

class Review {
  final String name;
  final String comment;
  final double rating;
  final AssetImage avatarImage;

  Review(
      {required this.name,
      required this.comment,
      required this.rating,
      required this.avatarImage});
}

final List<Review> reviews = [
  Review(
    name: "John Doe",
    comment: "Great place to visit!",
    rating: 5.0,
    avatarImage: AssetImage('assets/images/TourGuide/guide1.jpg'),
  ),
  Review(
    name: "Emily Smith",
    comment: "Wonderful experience! Highly recommended.",
    rating: 4.5,
    avatarImage: AssetImage('assets/images/TourGuide/guide2.jpg'),
  ),
  Review(
    name: "Michael Johnson",
    comment: "The best place I've ever been to!",
    rating: 5.0,
    avatarImage: AssetImage('assets/images/TourGuide/guide3.jpg'),
  ),
  Review(
    name: "Jessica Anderson",
    comment: "A hidden gem! Loved every moment.",
    rating: 4.0,
    avatarImage: AssetImage('assets/images/TourGuide/guide4.jpg'),
  ),
  Review(
    name: "Matthew Davis",
    comment: "Exceptional service and breathtaking views.",
    rating: 4.5,
    avatarImage: AssetImage('assets/images/TourGuide/guide5.jpg'),
  ),
  Review(
    name: "Olivia Wilson",
    comment: "An unforgettable adventure!",
    rating: 5.0,
    avatarImage: AssetImage('assets/images/TourGuide/guide6.jpg'),
  ),
  Review(
    name: "Daniel Thompson",
    comment: "The staff was incredibly friendly and helpful.",
    rating: 4.0,
    avatarImage: AssetImage('assets/images/TourGuide/guide1.jpg'),
  ),
  Review(
    name: "Sophia Martinez",
    comment: "I can't wait to go back! Absolutely loved it.",
    rating: 5.0,
    avatarImage: AssetImage('assets/images/TourGuide/guide2.jpg'),
  ),
  Review(
    name: "William Harris",
    comment: "A must-visit destination for nature lovers.",
    rating: 4.5,
    avatarImage: AssetImage('assets/images/TourGuide/guide3.jpg'),
  ),
  Review(
    name: "Ava Taylor",
    comment: "Incredible hospitality and stunning landscapes.",
    rating: 4.0,
    avatarImage: AssetImage('assets/images/TourGuide/guide4.jpg'),
  ),
  Review(
    name: "James Robinson",
    comment: "A perfect getaway for relaxation and adventure.",
    rating: 4.5,
    avatarImage: AssetImage('assets/images/TourGuide/guide5.jpg'),
  ),
  Review(
    name: "Mia Lewis",
    comment: "The experience exceeded my expectations.",
    rating: 5.0,
    avatarImage: AssetImage('assets/images/TourGuide/guide6.jpg'),
  ),
  Review(
    name: "Benjamin Turner",
    comment: "Unforgettable memories made here. Highly recommended!",
    rating: 1,
    avatarImage: AssetImage('assets/images/TourGuide/guide1.jpg'),
  ),
];

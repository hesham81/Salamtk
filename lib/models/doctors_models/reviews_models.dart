class ReviewsModels {
  final String? doctorId;
  List<Review>? reviews;

  ReviewsModels({
    required this.doctorId,
    required this.reviews,
  });

  factory ReviewsModels.fromJson(Map<String, dynamic> json) => ReviewsModels(
        doctorId: json["doctorId"],
        reviews: (json["reviews"] as List<dynamic>?)
                ?.map(
                  (e) => Review.fromJson(e),
                )
                .toList() ??
            null,
      );

  Map<String, dynamic> toJson() => {
        "doctorId": doctorId,
        "reviews": reviews?.map(
          (e) => e.toJson(),
        ),
      };
}

class Review {
  final String name;

  final String review;

  final double rating;

  final DateTime date;

  Review({
    required this.name,
    required this.review,
    required this.rating,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        name: json["name"],
        review: json["review"],
        rating: json["rating"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "rating": rating,
        "date": date.toIso8601String(),
      };
}

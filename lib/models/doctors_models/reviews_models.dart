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
  final String reservationId;

  final String name;

  final String patientId;

  final String review;

  final double rating;

  final DateTime date;

  Review({
    required this.reservationId,
    required this.name,
    required this.review,
    required this.rating,
    required this.date,
    required this.patientId,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        reservationId: json["reservationId"],
        name: json["name"],
        review: json["review"],
        rating: json["rating"],
        date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
        patientId: json["patientId"],
      );

  Map<String, dynamic> toJson() => {
        "reservationId": reservationId,
        "name": name,
        "review": review,
        "rating": rating,
        "date": date.millisecondsSinceEpoch,
        "patientId": patientId,
      };
}

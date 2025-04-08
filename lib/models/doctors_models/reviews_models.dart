class ReviewsModels {
   String? id;
  final String? doctorId;
  final String? userId;
  final String? review;
  final String? rating;
  final DateTime? date;

  ReviewsModels({
    required this.id,
    required this.doctorId,
    required this.userId,
    required this.review,
    required this.rating,
    required this.date,
  });

  factory ReviewsModels.fromJson(Map<String, dynamic> json) => ReviewsModels(
        id: json["id"],
        doctorId: json["doctorId"],
        userId: json["userId"],
        review: json["review"],
        rating: json["rating"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctorId": doctorId,
        "userId": userId,
        "review": review,
        "rating": rating,
        "date": date,
      };
}

class CoinsDataModel {
  final String userId;

   double totalCurrency;

   // double totalPoints;

   List<String> transactions;

  CoinsDataModel({
    required this.userId,
    required this.totalCurrency,
    // required this.totalPoints,
    required this.transactions,
  });

  CoinsDataModel.init({
    required this.userId,
    this.totalCurrency = 0.0,
    // this.totalPoints = 0.0,
    this.transactions = const [],
  });

  factory CoinsDataModel.fromMap(Map<String, dynamic> map) {
    return CoinsDataModel(
      userId: map['userId'],
      totalCurrency: map['totalCurrency'],
      // totalPoints: map['totalPoints'],
      transactions: List.from(map['transactions']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'totalCurrency': totalCurrency,
      // 'totalPoints': totalPoints,
      'transactions': transactions,
    };
  }
}

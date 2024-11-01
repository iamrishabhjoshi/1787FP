class Earnings {
  final String date;
  final double actualEps;
  final double estimatedEps;

  Earnings({required this.date, required this.actualEps, required this.estimatedEps});

  factory Earnings.fromJson(Map<String, dynamic> json) {
    return Earnings(
      date: json['pricedate'],
      actualEps: json['actual_eps'],
      estimatedEps: json['estimated_eps'],
    );
  }
}

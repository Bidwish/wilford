class TvPlan {
  final String name;
  final String provider;
  final String amount;
  final String validity;

  TvPlan({
    required this.name,
    required this.provider,
    required this.amount,
    required this.validity,
  });

  factory TvPlan.fromJson(Map<String, dynamic> json) {
    return TvPlan(
      name: json['name'] ?? '',
      amount: json['amount'].toString(),
      validity: json['validity'] ?? '',
      provider: json['provider'] ?? '',
    );
  }
}

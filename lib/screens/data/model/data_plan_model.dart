class DataPlan {
  final String name;
  final String network;
  final String amount;
  final String validity;
  final String note;
  final String duration;
  final String type;
  final String pts;

  DataPlan({
    required this.name,
    required this.network,
    required this.amount,
    required this.note,
    required this.validity,
    required this.duration,
    required this.type,
    required this.pts,
  });

  factory DataPlan.fromJson(Map<String, dynamic> json) {
    return DataPlan(
        name: json['name'] ?? '',
        amount: json['amount'].toString(),
        validity: json['validity'] ?? '',
        note: json['note'] ?? '',
        duration: json['duration'] ?? '',
        network: json['network'] ?? '',
        type: json['type'] ?? '',
        pts: json['earn'].toString());
  }
}

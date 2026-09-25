class GetMeter {
  final String name;
  final String validity;
  final Uri image;

  GetMeter({
    required this.name,
    required this.validity,
    required this.image,
  });

  factory GetMeter.fromJson(Map<String, dynamic> json) {
    return GetMeter(
      name: json['name'] ?? '',
      validity: json['validity'] ?? '',
      image: Uri.parse(json['image'] ?? ''),
    );
  }
}

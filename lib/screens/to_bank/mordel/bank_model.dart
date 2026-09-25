class GetBank {
  final String name;
  final String validity;
  final Uri image;

  GetBank({
    required this.name,
    required this.validity,
    required this.image,
  });

  factory GetBank.fromJson(Map<String, dynamic> json) {
    return GetBank(
      name: json['name'] ?? '',
      validity: json['validity'] ?? '',
      image: Uri.parse(json['image'] ?? ''),
    );
  }
}

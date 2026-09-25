class ReferModel {
  final String name;
  final String image;

  ReferModel({
    required this.name,
    required this.image,
  });

  factory ReferModel.fromJson(Map<String, dynamic> json) {
    return ReferModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

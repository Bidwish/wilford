class UserModel {
  final String id;
  final String fName;
  final String mName;
  final String lName;
  final String email;
  final String phone;
  final String dob;
  final String gender;
  final String profile;
  final String referral;
  final String bala;
  final String tier;
  final String username;

  UserModel({
    required this.id,
    required this.fName,
    required this.mName,
    required this.lName,
    required this.email,
    required this.bala,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.profile,
    required this.referral,
    required this.tier,
    required this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      fName: json['fName'] ?? '',
      lName: json['lName'] ?? '',
      mName: json['mName'] ?? '',
      email: json['email'] ?? '',
      bala: json['bala'].toString(),
      dob: json['dob']?.toString() ?? '',
      gender: json['gender'] ?? '',
      phone: json['phone'].toString(),
      profile: json['profile'] ?? '',
      referral: json['referral'] ?? '',
      tier: json['tier']?.toString() ?? '',
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fName': fName,
        'lName': lName,
        'mName': mName,
        'email': email,
        'bala': bala,
        'dob': dob,
        'gender': gender,
        'phone': phone,
        'profile': profile,
        'referral': referral,
        'tier': tier,
        'username': username,
      };
}

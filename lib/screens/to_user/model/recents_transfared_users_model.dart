class GetRecentWilfordTransferredUsers {
  final String accountNumber;
  final String accountName;
  final String bankName;
  final String bankCode;
  final Uri image;

  GetRecentWilfordTransferredUsers({
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.bankCode,
    required this.image,
  });

  factory GetRecentWilfordTransferredUsers.fromJson(Map<String, dynamic> json) {
    return GetRecentWilfordTransferredUsers(
      bankCode: json['bankCode'] ?? '',
      bankName: json['bankName'] ?? '',
      accountName: json['accountName'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      image: Uri.parse(json['image'] ?? ''),
    );
  }
}

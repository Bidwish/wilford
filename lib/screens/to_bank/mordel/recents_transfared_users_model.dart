class GetRecentsTransferredUsers {
  final String accountNumber;
  final String accountName;
  final String bankName;
  final String bankCode;
  final Uri image;

  GetRecentsTransferredUsers({
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.bankCode,
    required this.image,
  });

  factory GetRecentsTransferredUsers.fromJson(Map<String, dynamic> json) {
    return GetRecentsTransferredUsers(
      bankCode: json['bankCode'] ?? '',
      bankName: json['bankName'] ?? '',
      accountName: json['accountName'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      image: Uri.parse(json['image'] ?? ''),
    );
  }
}

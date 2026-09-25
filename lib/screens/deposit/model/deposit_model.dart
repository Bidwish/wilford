class DepositAcc {
  final String accountNumber;
  final String accountName;
  final String bankName;

  DepositAcc({
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
  });

  factory DepositAcc.fromJson(Map<String, dynamic> json) {
    return DepositAcc(
      accountName: json['accountName'] ?? '',
      accountNumber: json['accountNumber'].toString(),
      bankName: json['bankName'] ?? '',
    );
  }
}

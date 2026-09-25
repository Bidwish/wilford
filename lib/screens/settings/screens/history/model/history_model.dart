class HistoryModel {
  final String paymentId;
  final String userId;
  final String recId;
  final String senderAccNumber;
  final String senderAccName;
  final String senderBank;
  final String recAccNumber;
  final String recAccName;
  final String recBank;
  final String amount;
  final String method;
  final String remark;
  final String status;
  final String phone;
  final String email;
  final String network;
  final String dataName;
  final String mtNumber;
  final String provider;
  final String accName;
  final String serial;
  final String pin;
  final String pts;
  final String fee;
  final String transactionId;
  final String requestId;
  final String timeDate;

  HistoryModel({
    required this.paymentId,
    required this.userId,
    required this.recId,
    required this.senderAccNumber,
    required this.senderAccName,
    required this.senderBank,
    required this.recAccNumber,
    required this.recAccName,
    required this.recBank,
    required this.amount,
    required this.method,
    required this.remark,
    required this.status,
    required this.phone,
    required this.email,
    required this.network,
    required this.dataName,
    required this.mtNumber,
    required this.provider,
    required this.accName,
    required this.serial,
    required this.pin,
    required this.pts,
    required this.fee,
    required this.transactionId,
    required this.requestId,
    required this.timeDate,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
        paymentId: json['payment_id'] ?? json['reference'] ?? json['id'] ?? '',
        userId: (json['user_id'] ?? '').toString(),
        recId: json['rec_id'] ?? '',
        senderAccNumber: json['senderAccNumber'] ?? '',
        senderAccName: json['senderAccName'] ?? '',
        senderBank: json['senderBank'] ?? '',
        recAccNumber: json['recAccNumber'] ?? '',
        recAccName: json['recAccName'].toString(),
        recBank: json['recBank'].toString(),
        amount: (json['amount'] ?? '').toString(),
        method: json['method'].toString(),
        remark: json['remark'] ?? '',
        status: json['status'] ?? '',
        phone: json['phone'] ?? '',
        email: json['email'] ?? '',
        network: json['network'] ?? '',
        dataName: json['dataName'] ?? '',
        mtNumber: json['mtNumber'] ?? '',
        provider: json['provider'] ?? '',
        accName: json['accName'].toString(),
        serial: json['serial'].toString(),
        pin: json['pin'] ?? '',
        pts: json['pts'].toString(),
        fee: (json['fee'] ?? '').toString(),
        transactionId: json['transactionId'] ?? json['reference'] ?? '',
        requestId: json['requestId'] ?? '',
        timeDate: json['created_at'] ?? '');
  }
}

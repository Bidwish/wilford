class NotificationModel {
  final String paymentId;
  final String senderName;
  final String amount;
  final String status;
  final String time;

  NotificationModel({
    required this.paymentId,
    required this.senderName,
    required this.amount,
    required this.status,
    required this.time,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      paymentId: (json['payment_id'] ?? json['id'] ?? '').toString(),
      amount: (json['amount'] ?? '').toString(),
      status: json['read_at'] == null ? '2' : '0',
      senderName: json['senderName'] ?? json['title'] ?? '',
      time: json['created_at'].toString(),
    );
  }
}

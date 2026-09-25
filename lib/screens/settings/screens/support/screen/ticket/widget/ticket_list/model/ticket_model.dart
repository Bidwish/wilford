class TicketModel {
  final String dateTime;
  final String ticketId;
  final String issueType;
  final String issueDescription;
  final String status;
  final String pending;
  final String resolved;
  final String ongoing;
  final String total;

  TicketModel({
    required this.dateTime,
    required this.ticketId,
    required this.issueType,
    required this.issueDescription,
    required this.status,
    this.pending = '',
    this.resolved = '',
    this.ongoing = '',
    this.total = '',
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      dateTime: json['dateTime'] ?? '',
      ticketId: json['ticketId'].toString(),
      issueType: json['issueType'] ?? '',
      issueDescription: json['issueDescription'] ?? '',
      status: json['status'] ?? '',
      pending: json['pending'].toString(),
      resolved: json['resolved'].toString(),
      ongoing: json['ongoing'].toString(),
      total: json['total'].toString(),
    );
  }
}

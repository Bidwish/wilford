class TicketMessage {
  final String sender;
  final String message;
  final String timestamp;

  TicketMessage({
    required this.sender,
    required this.message,
    required this.timestamp,
  });

  factory TicketMessage.fromJson(Map<String, dynamic> json) {
    return TicketMessage(
      sender: json['sender'] ?? 'System',
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }
}

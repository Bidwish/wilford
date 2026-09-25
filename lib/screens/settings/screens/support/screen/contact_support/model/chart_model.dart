class ChatMessage {
  final String senderId;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.senderId,
    required this.message,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      senderId: json['sender'].toString(),
      message: json['message'] ?? '',
      timestamp:
          DateTime.tryParse(json['timestamp'] ?? json['created_at'] ?? '') ??
              DateTime.now(),
    );
  }
}

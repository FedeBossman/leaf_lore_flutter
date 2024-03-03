class ChatMessage {
  final String content;
  final DateTime? timestamp;
  final MessageRole role;
  final MessageStatus? status;

  ChatMessage({
    required this.content,
    this.timestamp,
    required this.role,
    this.status,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      content: json['content'],
      role: MessageRole.values.byName(json['role']),
      timestamp: json['timestamp'].toDate(),
    );
  }
}

enum MessageRole {
  system,
  user,
  assistant,
}

enum MessageStatus {
  sent, // Message has been sent
  received, // Message has been received by the server or the other party
  seen, // Message has been seen by the other party but not yet read
  read, // Message has been read by the other party
}
class Chat {
  final DateTime? createdDate;
  final String id;
  final String name;
  final bool defaultChat;
  final String latestMessage;

  Chat({
    this.createdDate,
    required this.id,
    required this.defaultChat,
    required this.name,
    required this.latestMessage,
  });
}

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
  sent,
  received, 
  seen, 
  read, 
}
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
}

enum MessageRole {
  user, // Messages sent by the user
  assistant, // Messages sent by the assistant
}

enum MessageStatus {
  sent, // Message has been sent
  received, // Message has been received by the server or the other party
  seen, // Message has been seen by the other party but not yet read
  read, // Message has been read by the other party
}
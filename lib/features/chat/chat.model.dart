import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMeta {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String id;
  final String name;
  final bool defaultChat;
  final String latestMessage;

  ChatMeta({
    this.createdAt,
    this.updatedAt,
    required this.id,
    required this.defaultChat,
    required this.name,
    required this.latestMessage,
  });

  factory ChatMeta.fromDocument(DocumentSnapshot doc) {
    return ChatMeta(
      id: doc.id,
      name: doc['name'],
      defaultChat: doc['defaultChat'],
      createdAt: doc['createdAt'].toDate(),
      updatedAt: doc['updatedAt'].toDate(),
      latestMessage: doc['messages'].last['content'],
    );
  }
}


class Chat {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String id;
  final String name;
  final bool defaultChat;
  final List<ChatMessage> messages;

  Chat({
    this.createdAt,
    this.updatedAt,
    required this.id,
    required this.defaultChat,
    required this.name,
    required this.messages,
  });

  factory Chat.fromDocument(DocumentSnapshot doc) {
    final messagesData = doc['messages'] as List<dynamic>?;

    return Chat(
      id: doc.id,
      name: doc['name'],
      defaultChat: doc['defaultChat'],
      createdAt: doc['createdAt'].toDate(),
      updatedAt: doc['updatedAt'].toDate(),
      messages: messagesData?.map((e) => ChatMessage.fromJson(e)).toList() ?? [],
    );
  }
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
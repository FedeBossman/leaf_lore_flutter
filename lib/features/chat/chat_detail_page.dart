import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat_detail_widget.dart';
import 'package:leaf_lore_flutter/features/chat/default_chat_loader_widget.dart';

class ChatDetailPage extends StatelessWidget {
  final String chatId;
  const ChatDetailPage({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return ChatDetailWidget(chatId: chatId);
  }
}
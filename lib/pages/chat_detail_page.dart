import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/widgets/chat_detail_widget.dart';
import 'package:leaf_lore_flutter/widgets/default_chat_loader_widget.dart';

class ChatDetailPage extends StatelessWidget {
  final String chatId;
  const ChatDetailPage({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChatDetailWidget(chatId: chatId)
      );
  }
}
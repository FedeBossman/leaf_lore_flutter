import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';
import 'package:leaf_lore_flutter/features/chat/chat_detail_widget.dart';
import 'package:leaf_lore_flutter/features/chat/chat_input_widget.dart';
import 'package:leaf_lore_flutter/features/chat/chat_stream.dart';

class ChatDetailPage extends StatelessWidget {
  final String chatId;
  const ChatDetailPage({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: StreamBuilder<Chat>(
              stream: getChatDetailStream(chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (!snapshot.hasData) {
                  return const Text("No chat messages found.");
                }

                var chat = snapshot.data!;
                
                return ChatDetailWidget(chat: chat);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0, top: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: ChatInputField(chatId: chatId)
                ),
              ],
            ),
          ),
        ],
    );
  }
}
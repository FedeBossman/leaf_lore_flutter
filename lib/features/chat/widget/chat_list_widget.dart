import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';
import 'package:leaf_lore_flutter/features/chat/widget/chat_list_item_widget.dart';

class ChatListWidget extends StatelessWidget {
  final List<ChatMeta> chats;

  const ChatListWidget({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ChatListItemWidget(chatMeta: chat);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 1),
    );
  }
}

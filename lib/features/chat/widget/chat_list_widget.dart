import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';
import 'package:leaf_lore_flutter/features/chat/widget/chat_list_item_widget.dart';

class ChatListWidget extends StatelessWidget {
  final List<ChatMeta> chats;

  const ChatListWidget({super.key, required this.chats});

  List<ChatMeta> _reorderList(List<ChatMeta> chatList) {
    int defaultChatIndex = chatList.indexWhere((chat) => chat.defaultChat);
    if (defaultChatIndex != -1) {
      var defaultChat = chatList.removeAt(defaultChatIndex);
      chatList.insert(0, defaultChat);
    }
    return chatList;
  }

  @override
  Widget build(BuildContext context) {
    final reorderedChat = _reorderList(chats);

    return ListView.separated(
      itemCount: reorderedChat.length,
      itemBuilder: (context, index) {
        final chat = reorderedChat[index];
        return ChatListItemWidget(chatMeta: chat);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 1),
    );
  }
}

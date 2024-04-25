import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';
import 'package:leaf_lore_flutter/features/chat/chat_detail_page.dart';

class ChatListWidget extends StatelessWidget {
  final List<ChatMeta> chats;

  const ChatListWidget({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ListTile(
          leading: const Icon(Icons.chat),
          title: Text(chat.name),
          subtitle: Text(
            chat.latestMessage,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ChatDetailPage(chatId: chat.id, chatName: chat.name)));
          },
        );
      },
    );
  }
}

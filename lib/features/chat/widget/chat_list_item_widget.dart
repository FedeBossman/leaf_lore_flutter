import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';
import 'package:leaf_lore_flutter/features/chat/chat_detail_page.dart';

class ChatListItemWidget extends StatelessWidget {
  final ChatMeta chatMeta;

  const ChatListItemWidget({super.key, required this.chatMeta});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8), // Add padding to each chat item
      child: ListTile(
          leading: CircleAvatar(
            child: Text(chatMeta.name[0]), // Display the first letter
          ),
          title: Text(chatMeta.name),
          subtitle: Text(
            chatMeta.latestMessage,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ChatDetailPage(
                        chatId: chatMeta.id, chatName: chatMeta.name)));
          }),
    );
  }
}

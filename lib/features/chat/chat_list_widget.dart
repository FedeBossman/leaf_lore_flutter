import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';
import 'package:leaf_lore_flutter/features/chat/chat_detail_page.dart';

class ChatListWidget extends StatelessWidget {
  final List<Chat> chats;

  ChatListWidget({Key? key, required this.chats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ListTile(
          leading: Icon(Icons.chat),
          title: Text(chat.name),
          subtitle: Text(chat.latestMessage),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatDetailPage(chatId: chat.id),
            ));
          },
        );
      },
    );
  }
}

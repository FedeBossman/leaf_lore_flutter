import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';
import 'package:leaf_lore_flutter/features/chat/chat_list_widget.dart';


List<Chat> chats = [
  Chat(id: 'KoVtjQbgayiq6nizpBBK', name: 'Gardening Assistant', latestMessage: 'How can I help you today?', defaultChat: true),
  Chat(id: 'KoVtjQbgayiq6nizpBBK', name: 'Aloe Vera', latestMessage: 'I need water!', defaultChat: false),
  Chat(id: 'KoVtjQbgayiq6nizpBBK', name: 'Fern', latestMessage: 'Feeling great today!', defaultChat: false),
];

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ChatListWidget(chats: chats)
      );
  }
}


class ChatNavigationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return const ChatPage(); 
          },
        );
      },
    );
  }
}
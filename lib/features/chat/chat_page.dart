import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';
import 'package:leaf_lore_flutter/features/chat/chat_list_widget.dart';
import 'package:leaf_lore_flutter/features/chat/chat_stream.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatMeta>>(
      stream: getChatsMetaStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData) {
          return Text('No chats found');
        }

        final chats = snapshot.data!;

        return ChatListWidget(chats: chats);
      },
    );
  }
}

class ChatNavigationWrapper extends StatelessWidget {
  const ChatNavigationWrapper({super.key});

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

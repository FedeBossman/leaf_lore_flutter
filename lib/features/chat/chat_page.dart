import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/widgets/stream_handler_widget.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';
import 'package:leaf_lore_flutter/features/chat/chat_list_widget.dart';
import 'package:leaf_lore_flutter/features/chat/chat_stream.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamHandler<List<ChatMeta>>(
      stream: getChatsMetaStream(),
      builder: (context, snapshot) {
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

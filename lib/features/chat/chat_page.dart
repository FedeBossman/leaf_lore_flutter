import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/core/widget/stream_handler_widget.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';
import 'package:leaf_lore_flutter/features/chat/widget/chat_list_widget.dart';
import 'package:leaf_lore_flutter/features/chat/chat_stream.dart';
import 'package:leaf_lore_flutter/shared/theme/main_app_bar_widget.dart';

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
  static const String tabIndex = 'ChatPage';
  const ChatNavigationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MainAppBar(title: context.loc.chatPage_title),
        body: const ChatPage(),
      ),
    );
  }
}

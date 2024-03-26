import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';

class ChatDetailWidget extends StatefulWidget {
  final Chat chat;
  const ChatDetailWidget({super.key, required this.chat});

  @override
  ChatDetailWidgetState createState() => ChatDetailWidgetState();
}

class ChatDetailWidgetState extends State<ChatDetailWidget> {
  Alignment getMessageAlignment(MessageRole role) {
    switch (role) {
      case MessageRole.user:
        return Alignment.centerRight;
      case MessageRole.assistant:
        return Alignment.centerLeft;
      case MessageRole.system:
        return Alignment.center;
    }
  }

  Color getMessageColor(MessageRole role) {
    switch (role) {
      case MessageRole.user:
        return Colors.lightGreen[400]!;
      case MessageRole.assistant:
        return Colors.blue[200]!;
      case MessageRole.system:
        return Colors.grey[300]!;
    }
  }

  EdgeInsets getMessageMargin(MessageRole role) {
    const roleMargin = 40.0;
    switch (role) {
      case MessageRole.user:
        return const EdgeInsets.only(
            left: roleMargin, right: 8, top: 4, bottom: 4);
      case MessageRole.assistant:
        return const EdgeInsets.only(
            right: roleMargin, left: 8, top: 4, bottom: 4);
      case MessageRole.system:
        return const EdgeInsets.symmetric(horizontal: roleMargin, vertical: 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: widget.chat.messages.length,
      itemBuilder: (context, index) {
        final message =
            widget.chat.messages[widget.chat.messages.length - 1 - index];
        return Align(
          alignment: getMessageAlignment(message.role),
          child: Container(
            margin: getMessageMargin(message.role),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: getMessageColor(message.role),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(message.content),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

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

  Color getMessageTextColor(MessageRole role) {
    switch (role) {
      case MessageRole.user:
        return LeafLoreColors.jet;
      case MessageRole.assistant:
        return LeafLoreColors.jet;
      case MessageRole.system:
        return LeafLoreColors.devGray;
    }
  }

  LinearGradient getMessageBackground(MessageRole role) {
    switch (role) {
      case MessageRole.user:
        return const LinearGradient(
                begin: Alignment.topLeft, 
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 148, 239, 224),
                  Color.fromARGB(255, 161, 234, 212),
                  Color.fromARGB(255, 131, 218, 162),
                ],
                stops: [0.05, 0.25, 0.85],
              );
      case MessageRole.assistant:
        return const LinearGradient(
                begin: Alignment.topLeft, 
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 86, 197, 249),
                  Color.fromARGB(255, 115, 217, 246),
                  Color.fromARGB(255, 115, 233, 248)

                ],
                stops: [0.05, 0.25, 0.85],
              );
      case MessageRole.system:
        return const LinearGradient(
                begin: Alignment.topLeft, 
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 54, 53, 98),
                  LeafLoreColors.spaceCadet,
                  Color.fromARGB(255, 36, 50, 68),

                ],
                stops: [0.05, 0.25, 0.85],
              );
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
              borderRadius: BorderRadius.circular(20),
              gradient: getMessageBackground(message.role),
            ),
            child: Text(message.content, style: TextStyle(color: getMessageTextColor(message.role)),),
          ),
        );
      },
    );
  }
}

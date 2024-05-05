import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';
import 'package:leaf_lore_flutter/shared/theme/debug.dart';

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
        return LeafLoreColors.tiffanyBlueGradient;
      case MessageRole.assistant:
        return LeafLoreColors.skyBlueGradient;
      case MessageRole.system:
        return LeafLoreColors.devGradient;
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

  BorderRadiusGeometry getBorderRadius(MessageRole role) {
    const radius = 20.0;
    switch (role) {
      case MessageRole.user:
        return const BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomRight: Radius.circular(radius),
            bottomLeft: Radius.circular(radius));
      case MessageRole.assistant:
        return const BorderRadius.only(
            bottomLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
            bottomRight: Radius.circular(radius));
      case MessageRole.system:
        return const BorderRadius.all(Radius.circular(radius));
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
        return Visibility(
          visible: debugMode || message.role != MessageRole.system,
          child: Align(
            alignment: getMessageAlignment(message.role),
            child: Container(
              margin: getMessageMargin(message.role),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: getBorderRadius(message.role),
                gradient: getMessageBackground(message.role),
              ),
              child: Text(
                message.content,
                style: TextStyle(color: getMessageTextColor(message.role)),
              ),
            ),
          ),
        );
      },
    );
  }
}
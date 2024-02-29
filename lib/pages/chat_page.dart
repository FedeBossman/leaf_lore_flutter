import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/widgets/chat_widget.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChatWidget()
      );
  }
}
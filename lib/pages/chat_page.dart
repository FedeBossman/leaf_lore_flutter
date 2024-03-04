import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/widgets/default_chat_loader_widget.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(16.0),
        child: DefaultChatLoaderWidget()
      );
  }
}
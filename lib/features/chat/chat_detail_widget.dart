import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';
import 'package:leaf_lore_flutter/features/chat/chat_input_widget.dart';


class ChatDetailWidget extends StatefulWidget {
  final String chatId;
  const ChatDetailWidget({super.key, required this.chatId});

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
        return const EdgeInsets.only(left: roleMargin, right: 8, top: 4, bottom: 4);
      case MessageRole.assistant:
        return const EdgeInsets.only(right: roleMargin, left: 8, top: 4, bottom: 4);
      case MessageRole.system:
        return const EdgeInsets.symmetric(horizontal: roleMargin, vertical: 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('chats').doc(widget.chatId).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                var document = snapshot.data!;
                var messagesData = document['messages'] as List<dynamic>?;
                var messages = messagesData != null
                    ? messagesData.map((messageJson) => ChatMessage.fromJson(messageJson)).toList()
                    : <ChatMessage>[];
                
                return ListView.builder(
                  reverse: true, // Stack messages from the bottom
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[messages.length - 1 - index]; // Reverse index for stacking from bottom
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
              },
            ),
          ),
          // Placeholder for message input field and send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ChatInputField(chatId: widget.chatId)
                ),
              ],
            ),
          ),
        ],
    );
  }
}
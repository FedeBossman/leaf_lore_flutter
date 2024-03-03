import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/model/chat_message.model.dart';


class ChatWidget extends StatefulWidget {
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _controller = TextEditingController();

  void sendMessage(String messageContent) async {
    if (messageContent.trim().isEmpty) {
      return;
    }
    debugPrint('Sending message: $messageContent');
    await sendFirebaseMessage(messageContent);
  }

  Future<void> sendFirebaseMessage(String messageContent) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('postMessage');
    try {
      final response = await callable.call({'chatId': 'Lz35JBgcWvHE1XNKmV3W', 'message': messageContent});
      debugPrint('Function result: ${response.data}');
    } catch (e) {
      debugPrint('Error calling function: $e');
    }
  }

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
        return EdgeInsets.only(left: roleMargin, right: 8, top: 4, bottom: 4);
      case MessageRole.assistant:
        return EdgeInsets.only(right: roleMargin, left: 8, top: 4, bottom: 4);
      case MessageRole.system:
        return EdgeInsets.symmetric(horizontal: roleMargin, vertical: 4);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('chats').doc('Lz35JBgcWvHE1XNKmV3W').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

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
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: Colors.lightGreen),
                        onPressed: () {
                          sendMessage(_controller.text); // Use the text from the controller
                          _controller.clear(); // Optionally clear the input after sending
                        },
                      ),
                    ),
                    controller: _controller,
                  ),
                ),
              ],
            ),
          ),
        ],
    );
  }
}

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendMessageIntent extends Intent {
  const SendMessageIntent();
}

class SendMessageAction extends Action<SendMessageIntent> {
  SendMessageAction(this.onSendMessage);

  final VoidCallback onSendMessage;

  @override
  void invoke(covariant SendMessageIntent intent) => onSendMessage();
}

class ChatInputField extends StatefulWidget {
  final String chatId;
  const ChatInputField({super.key, required this.chatId});

  @override
  ChatInputFieldState createState() => ChatInputFieldState();
}

class ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  bool _isSendingMessage = false;

  void sendMessage() async {
    final messageContent = _controller.text.trim();
    if (messageContent.trim().isEmpty) {
      return;
    }
    setState(() {
      _isSendingMessage = true;
    });
    _controller.clear();
    debugPrint('Sending message: $messageContent');
    await sendFirebaseMessage(messageContent);
    setState(() {
      _isSendingMessage = false;
    });
  }

  Future<void> sendFirebaseMessage(String messageContent) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('chat-postMessage');
    try {
      final response = await callable
          .call({'chatId': widget.chatId, 'message': messageContent});
      debugPrint('Function result: ${response.data}');
    } catch (e) {
      debugPrint('Error calling function: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.enter): const SendMessageIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          SendMessageIntent: SendMessageAction(sendMessage),
        },
        child: Focus(
          autofocus: true,
          child: TextField(
            style: const TextStyle(fontSize: 14.0, height: 1.0),
            decoration: InputDecoration(
              hintText: "Type a message",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              suffixIcon: _isSendingMessage
                  ? const CircularProgressIndicator()
                  : IconButton(
                      icon: const Icon(Icons.send, color: Colors.lightGreen),
                      onPressed: () => sendMessage(),
                    ),
            ),
            controller: _controller,
            onSubmitted: (_) => sendMessage(),
          ),
        ),
      ),
    );
  }
}

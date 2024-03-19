import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:leaf_lore_flutter/widgets/chat_detail_widget.dart';

class DefaultChatLoaderWidget extends StatelessWidget {
  const DefaultChatLoaderWidget({super.key});

  Future<String> getDefaultChat() async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getDefaultChat');
    final results = await callable.call({});
    return results.data['chatId'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getDefaultChat(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        return ChatDetailWidget(chatId: snapshot.data!); 
      },
    );
  }
}

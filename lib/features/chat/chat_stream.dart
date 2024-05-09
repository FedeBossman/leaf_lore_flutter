import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';

Stream<List<ChatMeta>> getChatsMetaStream() {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  return FirebaseFirestore.instance
      .collection('chats')
      .where('userId', isEqualTo: userId)
      // .where('defaultChat', isEqualTo: false)
      .orderBy('updatedAt', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => ChatMeta.fromDocument(doc)).toList());
}

Stream<ChatMeta?> getDefaultChatMetaStream() {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  return FirebaseFirestore.instance
      .collection('chats')
      .where('userId', isEqualTo: userId)
      .where('defaultChat', isEqualTo: true)
      .snapshots()
      .map((snapshot) {
    List<ChatMeta> chats =
        snapshot.docs.map((doc) => ChatMeta.fromDocument(doc)).toList();
    return chats.isNotEmpty ? chats.first : null;
  });
}

Stream<Chat> getChatDetailStream(String chatId) {
  return FirebaseFirestore.instance
      .collection('chats')
      .doc(chatId)
      .snapshots()
      .map((doc) => Chat.fromDocument(doc));
}

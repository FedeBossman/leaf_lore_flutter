import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';

Stream<List<ChatMeta>> getChatsMetaStream() {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  return FirebaseFirestore.instance
      .collection('chats')
      .where('userId', isEqualTo: userId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => ChatMeta.fromDocument(doc)).toList());
}

Stream<Chat> getChatDetailStream(String chatId) {
  return FirebaseFirestore.instance
      .collection('chats')
      .doc(chatId)
      .snapshots()
      .map((doc) => Chat.fromDocument(doc));
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaf_lore_flutter/features/home/model/home_page_info.model.dart';

Stream<HomePageInfo?> getHomePageInfoStream() {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  return FirebaseFirestore.instance
    .collection('homePageInfo')
    .where('userId', isEqualTo: userId)
    .orderBy('createdAt', descending: true)
    .limit(1)
    .snapshots()
    .map((snapshot) => (
      snapshot.docs.isNotEmpty ? snapshot.docs.first : null
    ))
    .map((data) => data != null ? HomePageInfo.fromSnapshot(data) : null);
}

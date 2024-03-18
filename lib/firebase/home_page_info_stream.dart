import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Stream<DocumentSnapshot> getHomePageInfoStream() {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  return FirebaseFirestore.instance
    .collection('homePageInfo')
    .where('userId', isEqualTo: userId)
    .orderBy('createdAt', descending: true)
    .limit(1)
    .snapshots()
    .map((snapshot) => snapshot.docs.first);
}

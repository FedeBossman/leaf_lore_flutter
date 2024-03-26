import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaf_lore_flutter/features/plants/plant_model.dart';

const plantsCollection = 'plants';

Stream<List<PlantMeta>> getPlantsMetaStream() {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  return FirebaseFirestore.instance
      .collection(plantsCollection)
      .where('userId', isEqualTo: userId)
      .orderBy('name', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => PlantMeta.fromDocument(doc)).toList());
}

Stream<Plant> getPlantDetailStream(String plantId) {
  return FirebaseFirestore.instance
      .collection(plantsCollection)
      .doc(plantId)
      .snapshots()
      .map((doc) => Plant.fromDocument(doc));
}

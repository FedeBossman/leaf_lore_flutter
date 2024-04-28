import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leaf_lore_flutter/core/model/user_owned_model.dart';

import 'plant_enum.dart';

class PlantMeta {
  final String id;
  final String name;
  final String nickname;

  PlantMeta({required this.id, required this.name, required this.nickname});

  factory PlantMeta.fromDocument(DocumentSnapshot doc) {
    return PlantMeta(
      id: doc.id,
      name: doc['name'],
      nickname: doc['nickname'],
    );
  }
}

class Plant extends UserOwned {
  String id;
  String name;
  String nickname;
  // DateTime startDate;
  CareLevel careLevel;
  SunlightRequirement sunlightRequirement;
  WateringFrequency wateringFrequency;
  FertilizationFrequency fertilizationFrequency;
  SoilType soilType;
  PotSize potSize;
  HumidityRequirement humidityRequirement;
  String? notes;

  Plant({
    required super.userId,
    required this.id,
    required this.name,
    required this.nickname,
    // required this.startDate,
    required this.careLevel,
    required this.sunlightRequirement,
    required this.wateringFrequency,
    required this.fertilizationFrequency,
    required this.soilType,
    required this.potSize,
    required this.humidityRequirement,
    this.notes,
  });

  factory Plant.fromDocument(DocumentSnapshot doc) {
    return Plant(
      id: doc.id,
      userId: doc['userId'],
      name: doc['name'],
      nickname: doc['nickname'],
      // startDate: doc['startDate']?.toDate(),
      careLevel: CareLevel.values.byName(doc['careLevel']),
      sunlightRequirement:
          SunlightRequirement.values.byName(doc['sunlightRequirement']),
      wateringFrequency:
          WateringFrequency.values.byName(doc['wateringFrequency']),
      fertilizationFrequency:
          FertilizationFrequency.values.byName(doc['fertilizationFrequency']),
      soilType: SoilType.values.byName(doc['soilType']),
      potSize: PotSize.values.byName(doc['potSize']),
      humidityRequirement:
          HumidityRequirement.values.byName(doc['humidityRequirement']),
      notes: doc['notes'],
    );
  }
}

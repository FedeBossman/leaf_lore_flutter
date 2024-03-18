import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageInfo {
  final String userId;
  final String experience;
  final List<String> goals;
  final String nickname;
  final Location location;
  final String type;

  HomePageInfo({
    required this.userId,
    required this.experience,
    required this.goals,
    required this.nickname,
    required this.location,
    required this.type,
  });

  factory HomePageInfo.fromMap(Map<String, dynamic> data) {
    return HomePageInfo(
      userId: data['userId'] as String,
      experience: data['experience'] as String,
      goals: List<String>.from(data['goals']),
      nickname: data['nickname'] as String,
      location: Location.fromMap(data['location'] as Map<String, dynamic>),
      type: data['type'] as String,
    );
  }

  
  factory HomePageInfo.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return HomePageInfo.fromMap(data);
  }
}

class Location {
  final String? city;
  final String? state;
  final String? country;
  final String? type;

  Location({
    this.city,
    required this.state,
    required this.country,
    required this.type,
  });

  // fromMap
  factory Location.fromMap(Map<String, dynamic> data) {
    return Location(
      city: data['city'] as String?,
      state: data['state'] as String?,
      country: data['country'] as String?,
      type: data['type'] as String?,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageInfo {
  final String userId;
  final String? experience;
  final List<String> goals;
  final String? nickname;
  final Location? location;
  final String? type;
  final int plantsCount;
  final Weather? weather;

  HomePageInfo({
    required this.userId,
    this.experience,
    required this.goals,
    required this.nickname,
    required this.location,
    required this.weather,
    required this.type,
    required this.plantsCount,
  });

  factory HomePageInfo.fromMap(Map<String, dynamic> data) {
    return HomePageInfo(
      userId: data['userId'] as String,
      experience: data['experience'] as String?,
      goals: List<String>.from(data['goals']),
      nickname: data['nickname'] as String?,
      location: data['location'] != null ? Location.fromMap(data['location'] as Map<String, dynamic>) : null,
      weather: data['weather'] != null ? Weather.fromMap(data['weather'] as Map<String, dynamic>) : null,
      type: data['type'] as String?,
      plantsCount: data['plantsCount'] as int,
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

class Weather {
  final int temperature;
  final int humidity;
  final String description;

  Weather({
    required this.temperature,
    required this.humidity,
    required this.description,
  });

  factory Weather.fromMap(Map<String, dynamic> data) {
    return Weather(
      temperature: (data['temperature'] as double).round(),
      humidity: data['humidity'] as int,
      description: data['description'] as String,
    );
  }
}
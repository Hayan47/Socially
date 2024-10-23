import 'package:socially/data/models/user_model.dart';

class Story {
  final String id;
  final User user;
  final String imageUrl;
  final DateTime timestamp;

  Story({
    required this.id,
    required this.user,
    required this.imageUrl,
    required this.timestamp,
  });

  // Converts a JSON map to a Story instance
  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'] as String,
      user: User.fromJson(json['user']
          as Map<String, dynamic>), // Assuming User has a fromJson method
      imageUrl: json['imageUrl'] as String,
      timestamp:
          DateTime.parse(json['timestamp'] as String), // Convert to DateTime
    );
  }

  // Converts a Story instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(), // Assuming User has a toJson method
      'imageUrl': imageUrl,
      'timestamp':
          timestamp.toIso8601String(), // Convert DateTime to ISO 8601 String
    };
  }
}

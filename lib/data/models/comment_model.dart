import 'package:socially/data/models/user_model.dart';

class Comment {
  final String id;
  final User user;
  final String content;
  final DateTime timestamp;
  final List<Comment> replies;
  final bool isLiked;

  Comment({
    required this.id,
    required this.user,
    required this.content,
    required this.timestamp,
    required this.replies,
    required this.isLiked,
  });

  // Converts a JSON map to a Comment instance
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      user: User.fromJson(json['user']
          as Map<String, dynamic>), // Assuming User has a fromJson method
      content: json['content'] as String,
      timestamp:
          DateTime.parse(json['timestamp'] as String), // Convert to DateTime
      replies: (json['replies'] as List<dynamic>)
          .map((replyJson) => Comment.fromJson(replyJson))
          .toList(),
      isLiked: json['isLiked'],
    );
  }

  // Converts a Comment instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(), // Assuming User has a toJson method
      'content': content,
      'timestamp':
          timestamp.toIso8601String(), // Convert DateTime to ISO 8601 String
      'replies': replies.map((reply) => reply.toJson()).toList(),
      'isLiked': isLiked,
    };
  }
}

import 'package:socially/data/models/comment_model.dart';
import 'package:socially/data/models/user_model.dart';

class Post {
  final String id;
  final User user;
  final String content;
  final List<String> imageUrls;
  final DateTime timestamp;
  final int likes;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.user,
    required this.content,
    required this.imageUrls,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });

  // Converts a JSON map to a Post instance
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      user: User.fromJson(json['user']
          as Map<String, dynamic>), // Assuming User has a fromJson method
      content: json['content'] as String,
      imageUrls: (json['imageUrls'] as List<String>).toList(),
      timestamp:
          DateTime.parse(json['timestamp'] as String), // Convert to DateTime
      likes: json['likes'] as int,
      comments: (json['comments'] as List<dynamic>)
          .map((commentJson) => Comment.fromJson(commentJson as Map<String,
              dynamic>)) // Assuming Comment has a fromJson method
          .toList(),
    );
  }

  // Converts a Post instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(), // Assuming User has a toJson method
      'content': content,
      'imageUrl': imageUrls,
      'timestamp':
          timestamp.toIso8601String(), // Convert DateTime to ISO 8601 String
      'likes': likes,
      'comments': comments
          .map((comment) => comment.toJson())
          .toList(), // Assuming Comment has a toJson method
    };
  }
}

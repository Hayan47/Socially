// Generate mock data
import 'package:socially/data/logger_service.dart';
import 'package:socially/data/models/comment_model.dart';
import 'package:socially/data/models/post_model.dart';
import 'package:socially/data/models/story_model.dart';
import 'package:socially/data/models/user_model.dart';
import 'dart:math';
import 'dart:async';

class MockApiService {
  final List<User> _users;
  final List<Post> _posts;
  final List<Story> _stories;
  final _logger = LoggerService().getLogger('MockApi Logger');

  MockApiService()
      : _users = generateUsers(7),
        _posts = [],
        _stories = [] {
    _posts.addAll(generatePosts(_users, 20));
    _stories.addAll(generateStories(_users, 20));
  }

  Future<List<Post>> fetchPosts() async {
    await Future.delayed(const Duration(seconds: 2));
    return _posts;
  }

  Future<List<Story>> fetchStories() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _stories;
  }

  Future<void> addComment(String postId, String userId, String content) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final post = _posts.firstWhere((post) => post.id == postId);
    final user = _users.firstWhere((user) => user.id == userId);

    post.comments.add(
      Comment(
        id: 'comment_${post.comments.length + 1}',
        user: user,
        content: content,
        timestamp: DateTime.now(),
        isLiked: false,
        replies: [],
      ),
    );
  }
}

List<User> generateUsers(int count) {
  return List.generate(
      count,
      (index) => User(
            id: '$index',
            name: 'User ${index + 1}',
            avatarUrl: 'assets/images/I04-${index + 1}.png',
          ));
}

List<Post> generatePosts(List<User> users, int count) {
  final random = Random();
  return List.generate(
    count,
    (index) => Post(
      id: '$index',
      user: users[random.nextInt(users.length)],
      content: 'This is post number ${index + 1}',
      imageUrls: generateRandomPhotos(index),
      timestamp: DateTime.now().subtract(Duration(hours: random.nextInt(24))),
      likes: random.nextInt(100),
      comments: generateComments(users, random.nextInt(5)),
    ),
  );
}

List<Comment> generateComments(List<User> users, int count) {
  final random = Random();
  return List.generate(
      count,
      (index) => Comment(
            id: 'comment_$index',
            user: users[random.nextInt(users.length)],
            content: 'This is comment number ${index + 1}',
            timestamp:
                DateTime.now().subtract(Duration(minutes: random.nextInt(60))),
            isLiked: false,
            replies: [
              Comment(
                id: 'comment_reply_$index',
                user: users[random.nextInt(users.length)],
                content: 'This is reply number ${index + 1}',
                timestamp: DateTime.now()
                    .subtract(Duration(minutes: random.nextInt(60))),
                isLiked: false,
                replies: [],
              ),
            ],
          ));
}

List<Story> generateStories(List<User> users, int count) {
  final random = Random();
  return List.generate(
      count,
      (index) => Story(
            id: 'story_$index',
            user: users[random.nextInt(users.length)],
            imageUrl: 'https://picsum.photos/seed/$index/400/800',
            timestamp:
                DateTime.now().subtract(Duration(hours: random.nextInt(24))),
          ));
}

List<String> generateRandomPhotos(int index) {
  final Random _random = Random();
  // Randomly decide how many photos (0 to 3)
  final int numberOfPhotos = _random.nextInt(4); // 0 to 3

  if (numberOfPhotos == 0) {
    return [];
  }

  return List.generate(
    numberOfPhotos,
    (photoIndex) => 'https://picsum.photos/seed/${index}_${photoIndex}/400/400',
  );
}

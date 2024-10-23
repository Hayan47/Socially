import 'package:socially/data/models/story_model.dart';
import 'package:socially/data/models/user_model.dart';

class UserStories {
  final User user;
  final List<Story> stories;
  final bool viewed;

  UserStories({
    required this.user,
    required this.stories,
    this.viewed = false,
  });

  // Helper method to get the latest story timestamp
  DateTime get latestTimestamp =>
      stories.map((s) => s.timestamp).reduce((a, b) => a.isAfter(b) ? a : b);
}

// Extension method to group stories by user
extension StoriesGrouping on List<Story> {
  List<UserStories> groupByUser() {
    final Map<String, List<Story>> groupedStories = {};

    // Group stories by user ID
    for (final story in this) {
      final userId = story.user.id;
      if (!groupedStories.containsKey(userId)) {
        groupedStories[userId] = [];
      }
      groupedStories[userId]!.add(story);
    }

    // Convert to list of UserStories and sort by latest story
    return groupedStories.entries
        .map((entry) => UserStories(
              user: entry.value.first.user,
              stories: entry.value
                ..sort((a, b) => a.timestamp.compareTo(b.timestamp)),
            ))
        .toList()
      ..sort((a, b) => b.latestTimestamp.compareTo(a.latestTimestamp));
  }
}

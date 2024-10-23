import 'package:flutter/material.dart';
import 'package:socially/data/models/story_model.dart';
import 'package:socially/data/models/user_stories_model.dart';
import 'package:socially/presentation/screens/status_view.dart';
import 'package:socially/presentation/widgets/story_bubble.dart';

class StoryBubblesList extends StatelessWidget {
  final List<Story> stories;

  const StoryBubblesList({
    super.key,
    required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    final userStories = stories.groupByUser();
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.5),
      itemCount: userStories.length,
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final userStory = userStories[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => StatusScreen(
                  userStories: userStories,
                  initialUserIndex: index,
                ),
              ),
            );
          },
          child: StoryBubble(
            userStories: userStory,
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:socially/data/models/user_stories_model.dart';

class StoryBubble extends StatelessWidget {
  final UserStories userStories;

  const StoryBubble({
    super.key,
    required this.userStories,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.5),
      child: Container(
        width: 57.48,
        height: 57.48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: userStories.viewed ? Colors.grey : Colors.white,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage(userStories.user.avatarUrl),
          ),
        ),
      ),
    );
  }
}

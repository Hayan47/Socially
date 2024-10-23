import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socially/data/models/user_stories_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:story/story_page_view.dart';

class StatusScreen extends StatefulWidget {
  final List<UserStories> userStories;
  final int initialUserIndex;

  const StatusScreen({
    super.key,
    required this.userStories,
    required this.initialUserIndex,
  });

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  late int _currentUserIndex;

  @override
  void initState() {
    super.initState();
    _currentUserIndex = widget.initialUserIndex;
  }

  @override
  Widget build(BuildContext context) {
    final isBigWidth = MediaQuery.sizeOf(context).width > 600;
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta! > 7) {
              Navigator.pop(context);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isBigWidth
                  ? GestureDetector(
                      onTap: () {
                        // todo
                      },
                      child: Image.asset('assets/icons/back_button.png'))
                  : Container(),
              SizedBox(width: isBigWidth ? 10 : 0),
              AspectRatio(
                aspectRatio: isBigWidth ? 9 / 16 : width / height,
                child: StoryPageView(
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
                  indicatorHeight: 3,
                  initialPage: _currentUserIndex,
                  onPageChanged: (int userIndex) {
                    setState(() {
                      _currentUserIndex = userIndex;
                    });
                  },
                  onPageLimitReached: () {
                    Navigator.pop(context);
                  },
                  indicatorVisitedColor: Colors.white,
                  indicatorDuration: const Duration(seconds: 15),
                  itemBuilder: (context, userIndex, storyIndex) {
                    final userStory = widget.userStories[userIndex];
                    final story = userStory.stories[storyIndex];
                    return Stack(
                      children: [
                        // Story Image
                        Positioned.fill(
                          child: Container(
                            color: Colors.black,
                            child: CachedNetworkImage(
                              imageUrl: story.imageUrl,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                        // User Info Header
                        Positioned(
                          top: 20,
                          left: 10,
                          right: 10,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundImage:
                                      AssetImage(userStory.user.avatarUrl),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userStory.user.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      timeago.format(story.timestamp),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset('assets/icons/download.png'),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 15,
                          child: Image.asset('assets/icons/like.png'),
                        )
                      ],
                    );
                  },
                  storyLength: (int userIndex) {
                    return widget.userStories[userIndex].stories.length;
                  },
                  pageLength: widget.userStories.length,
                ),
              ),
              SizedBox(width: isBigWidth ? 10 : 0),
              isBigWidth
                  ? GestureDetector(
                      onTap: () {
                        // todo
                      },
                      child: Image.asset('assets/icons/forward_button.png'))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

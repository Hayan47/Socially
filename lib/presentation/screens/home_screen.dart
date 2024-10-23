import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:socially/logic/post_bloc/post_bloc.dart';
import 'package:socially/logic/story_bloc/story_bloc.dart';
import 'package:socially/presentation/themes/app_colors.dart';
import 'package:socially/presentation/themes/app_typography.dart';
import 'package:socially/presentation/widgets/post_widget.dart';
import 'package:socially/presentation/widgets/story_bubbles_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isBigWidth = MediaQuery.sizeOf(context).width > 600;
    return LiquidPullToRefresh(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          context.read<StoryBloc>().add(GetStories());
          context.read<PostBloc>().add(GetPosts());
        },
        animSpeedFactor: 1,
        springAnimationDurationInMilliseconds: 100,
        showChildOpacityTransition: false,
        height: 200,
        color: Colors.transparent,
        backgroundColor: AppColors.whiteMediumTransparent,
        child: isBigWidth
            ? Column(
                children: [
                  //! Stories section (fixed)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(48),
                      child: Container(
                        color: AppColors.navyBlue.withOpacity(0.5),
                        height: 76,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: BlocConsumer<StoryBloc, StoryState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              if (state is StoryLoaded) {
                                return StoryBubblesList(stories: state.stories);
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  //! Posts section (scrollable)
                  Expanded(
                    child: BlocConsumer<PostBloc, PostState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is PostLoaded) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              final maxWidth =
                                  MediaQuery.sizeOf(context).width > 800;
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  width: maxWidth ? 800 : constraints.maxWidth,
                                  color: AppColors.white,
                                  child: Column(
                                    children: [
                                      //! Search Field
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 12),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            width: 318,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors
                                                    .blackMediumTransparent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: TextField(
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: 'Search',
                                                hintStyle: AppTypography
                                                    .bodyLarge
                                                    .copyWith(
                                                        color: AppColors
                                                            .blackMediumTransparent),
                                                prefixIcon: const Icon(
                                                    Icons.search,
                                                    color: AppColors
                                                        .blackMediumTransparent),
                                                filled: true,
                                                fillColor: AppColors.white,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 15),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: BorderSide.none,
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: const BorderSide(
                                                      color: AppColors.navyBlue,
                                                      width: 1),
                                                ),
                                              ),
                                              style: AppTypography.bodyLarge
                                                  .copyWith(
                                                      color:
                                                          AppColors.darkerGray),
                                              onChanged: (value) {
                                                // Handle search
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: state.posts.length,
                                          itemBuilder: (context, index) {
                                            return PostWidget(
                                                post: state.posts[index]);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              )
            : ListView(
                children: [
                  //! App Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      title: Image.asset('assets/images/socially.png'),
                      centerTitle: true,
                      leading: Image.asset('assets/icons/notification.png'),
                    ),
                  ),
                  //! Stories
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(48),
                      child: Container(
                        color: AppColors.navyBlue.withOpacity(0.5),
                        height: 76,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: BlocConsumer<StoryBloc, StoryState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              if (state is StoryLoaded) {
                                return StoryBubblesList(stories: state.stories);
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  //! Posts
                  BlocConsumer<PostBloc, PostState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is PostLoaded) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              color: Colors.transparent,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.posts.length,
                                itemBuilder: (context, index) {
                                  return PostWidget(post: state.posts[index]);
                                },
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ));
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/data/apis/mock_apis.dart';
import 'package:socially/data/caching_service.dart';
import 'package:socially/data/models/post_model.dart';
import 'package:socially/data/repositories/spcial_repository.dart';
import 'package:socially/logic/comment_bloc/comment_bloc.dart';
import 'package:socially/logic/post_bloc/post_bloc.dart';
import 'package:socially/logic/story_bloc/story_bloc.dart';
import 'package:socially/presentation/screens/comments_section.dart';
import 'package:socially/presentation/screens/main_screen.dart';

class AppRouter {
  late SocialRepository socialRepository;
  late StoryBloc storyBloc;
  late MockApiService apiService;
  late CachingService cachingService;
  late Connectivity connectivity;
  late PostBloc postBloc;
  late CommentBloc commentBloc;

  AppRouter() {
    apiService = MockApiService();
    cachingService = CachingService();
    connectivity = Connectivity();
    socialRepository =
        SocialRepository(apiService, cachingService, connectivity);
    storyBloc = StoryBloc(socialRepository: socialRepository);
    postBloc = PostBloc(socialRepository: socialRepository);
    commentBloc = CommentBloc(socialRepository: socialRepository);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: storyBloc),
              BlocProvider.value(value: postBloc),
              BlocProvider.value(value: commentBloc),
            ],
            child: const MainScreen(),
          ),
        );
      case 'commentspage':
        final post = settings.arguments as Post;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: commentBloc,
            child: CommentSection(post: post, currentUserId: '1'),
          ),
        );
    }
    return null;
  }

  void dispose() {
    storyBloc.close();
  }
}

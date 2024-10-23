import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:socially/data/models/post_model.dart';
import 'package:socially/data/models/story_model.dart';

class CachingService {
  static const String POSTS_KEY = 'cached_posts';
  static const String STORIES_KEY = 'cached_stories';

  Future<void> cachePosts(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();
    final String postsJson = jsonEncode(posts.map((p) => p.toJson()).toList());
    await prefs.setString(POSTS_KEY, postsJson);
  }

  Future<List<Post>> getCachedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? postsJson = prefs.getString(POSTS_KEY);
    if (postsJson == null) return [];
    final List<dynamic> postsList = jsonDecode(postsJson);
    return postsList.map((json) => Post.fromJson(json)).toList();
  }

  Future<void> cacheStories(List<Story> stories) async {
    final prefs = await SharedPreferences.getInstance();
    final String storiesJson =
        jsonEncode(stories.map((s) => s.toJson()).toList());
    await prefs.setString(STORIES_KEY, storiesJson);
  }

  Future<List<Story>> getCachedStories() async {
    final prefs = await SharedPreferences.getInstance();
    final String? storiesJson = prefs.getString(STORIES_KEY);
    if (storiesJson == null) return [];
    final List<dynamic> storiesList = jsonDecode(storiesJson);
    return storiesList.map((json) => Story.fromJson(json)).toList();
  }
}

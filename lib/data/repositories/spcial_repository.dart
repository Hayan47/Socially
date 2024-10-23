import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:socially/data/apis/mock_apis.dart';
import 'package:socially/data/caching_service.dart';
import 'package:socially/data/models/post_model.dart';
import 'package:socially/data/models/story_model.dart';

class SocialRepository {
  final MockApiService _apiService;
  final CachingService _cachingService;
  final Connectivity _connectivity;

  SocialRepository(this._apiService, this._cachingService, this._connectivity);

  Future<List<Post>> getPosts() async {
    if (await _hasInternetConnection()) {
      final posts = await _apiService.fetchPosts();
      await _cachingService.cachePosts(posts);
      return posts;
    } else {
      return await _cachingService.getCachedPosts();
    }
  }

  Future<List<Story>> getStories() async {
    if (await _hasInternetConnection()) {
      final stories = await _apiService.fetchStories();
      await _cachingService.cacheStories(stories);
      return stories;
    } else {
      return await _cachingService.getCachedStories();
    }
  }

  Future<void> addComment(String postId, String userId, String content) async {
    if (await _hasInternetConnection()) {
      await _apiService.addComment(postId, userId, content);
      // Refetch and cache updated posts
      final updatedPosts = await _apiService.fetchPosts();
      await _cachingService.cachePosts(updatedPosts);
    } else {
      throw Exception('No internet connection. Unable to add comment.');
    }
  }

  Future<bool> _hasInternetConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}

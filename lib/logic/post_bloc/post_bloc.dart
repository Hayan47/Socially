import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socially/data/models/post_model.dart';
import 'package:socially/data/repositories/spcial_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final SocialRepository socialRepository;
  PostBloc({required this.socialRepository}) : super(PostInitial()) {
    on<GetPosts>(
      (event, emit) async {
        try {
          emit(PostLoading());
          final posts = await socialRepository.getPosts();
          emit(PostLoaded(posts: posts));
        } catch (e) {
          emit(const PostError(message: 'Error Getting Stories'));
        }
      },
    );
  }
}

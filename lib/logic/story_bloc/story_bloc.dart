import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/data/models/story_model.dart';
import 'package:socially/data/repositories/spcial_repository.dart';
part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final SocialRepository socialRepository;
  StoryBloc({required this.socialRepository}) : super(StoryInitial()) {
    on<GetStories>((event, emit) async {
      try {
        emit(StoryLoading());
        final stories = await socialRepository.getStories();
        emit(StoryLoaded(stories: stories));
      } catch (e) {
        emit(const StoryError(message: 'Error Getting Stories'));
      }
    });
  }
}

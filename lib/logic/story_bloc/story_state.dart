part of 'story_bloc.dart';

sealed class StoryState extends Equatable {
  const StoryState();

  @override
  List<Object> get props => [];
}

final class StoryInitial extends StoryState {}

final class StoryLoading extends StoryState {}

final class StoryLoaded extends StoryState {
  final List<Story> stories;

  const StoryLoaded({required this.stories});

  @override
  List<Object> get props => [stories];
}

final class StoryError extends StoryState {
  final String message;

  const StoryError({required this.message});

  @override
  List<Object> get props => [message];
}

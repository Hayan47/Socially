part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class AddComment extends CommentEvent {
  final String postid;
  final String userid;
  final String content;

  const AddComment(
      {required this.postid, required this.userid, required this.content});
}

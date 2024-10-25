import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/data/logger_service.dart';
import 'package:socially/data/repositories/spcial_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final SocialRepository socialRepository;
  final _logger = LoggerService().getLogger('Comment Bloc Logger');
  CommentBloc({required this.socialRepository}) : super(CommentInitial()) {
    on<AddComment>(
      (event, emit) async {
        try {
          emit(CommentLoading());
          _logger.info(state);
          await socialRepository.addComment(
              event.postid, event.userid, event.content);
          emit(const CommentAdded(message: 'Comment Added Successfully'));
          _logger.info(state);
        } catch (e) {
          emit(const CommentError(message: 'Error Adding Comment'));
          _logger.severe(state);
          _logger.severe(e);
        }
      },
    );
  }
}

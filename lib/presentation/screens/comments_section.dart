import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/data/models/post_model.dart';
import 'package:socially/logic/comment_bloc/comment_bloc.dart';
import 'package:socially/presentation/themes/app_colors.dart';
import 'package:socially/presentation/themes/app_typography.dart';
import 'package:socially/presentation/widgets/comment_widget.dart';
import 'package:socially/presentation/widgets/snackbar.dart';

class CommentSection extends StatefulWidget {
  final Post post;
  final String currentUserId;
  const CommentSection({
    super.key,
    required this.post,
    required this.currentUserId,
  });

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? replyingTo;

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! > 7) {
          Navigator.pop(context);
        }
      },
      child: BlocConsumer<CommentBloc, CommentState>(
        listener: (context, state) {
          if (state is CommentError) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              MySnackBar(
                icon: const Icon(Icons.error, color: AppColors.error, size: 18),
                message: state.message,
              ),
            );
          } else if (state is CommentAdded) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              MySnackBar(
                icon:
                    const Icon(Icons.done, color: AppColors.success, size: 18),
                message: state.message,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comments',
                    style: AppTypography.h3.copyWith(
                      color: AppColors.navyBlue,
                    ),
                  ),
                  Text('${widget.post.comments.length} comments',
                      style: AppTypography.bodyMedium
                          .copyWith(color: AppColors.grayTransparent)),
                ],
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.blackMediumTransparent,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    itemCount: widget.post.comments.length,
                    itemBuilder: (context, index) {
                      final comment = widget.post.comments[index];
                      return CommentCard(
                        comment: comment,
                        currentUserId: widget.currentUserId,
                        onReply: (String username) {
                          setState(() {
                            replyingTo = username;
                            _commentController.text = '@$username ';
                          });
                          _focusNode.requestFocus();
                        },
                        onLike: () {
                          // todo
                        },
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (replyingTo != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          color: Colors.grey[100],
                          child: Row(
                            children: [
                              Text('Replying to @$replyingTo',
                                  style: AppTypography.bodySmall
                                      .copyWith(color: AppColors.lightGray)),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.close, size: 16),
                                onPressed: () {
                                  setState(() {
                                    replyingTo = null;
                                    _commentController.clear();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const CircleAvatar(
                                radius: 18,
                                backgroundImage:
                                    AssetImage('assets/images/I04-1.png')),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _commentController,
                                focusNode: _focusNode,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Write a comment...",
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.send,
                                  color: AppColors.navyBlue),
                              onPressed: () {
                                if (_commentController.text.isEmpty) return;
                                context.read<CommentBloc>().add(
                                      AddComment(
                                        postid: widget.post.id,
                                        userid: widget.currentUserId,
                                        content: _commentController.text,
                                        // replyTo: replyingTo,
                                      ),
                                    );
                                _commentController.clear();
                                setState(() {
                                  replyingTo = null;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

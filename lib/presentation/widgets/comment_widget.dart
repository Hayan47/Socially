import 'package:flutter/material.dart';
import 'package:socially/data/models/comment_model.dart';
import 'package:socially/presentation/themes/app_colors.dart';
import 'package:socially/presentation/themes/app_typography.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentCard extends StatelessWidget {
  final Comment comment;
  final String currentUserId;
  final Function(String) onReply;
  final VoidCallback onLike;

  const CommentCard({
    super.key,
    required this.comment,
    required this.currentUserId,
    required this.onReply,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage(comment.user.avatarUrl),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.user.name,
                        style: AppTypography.h4,
                      ),
                      const SizedBox(height: 4),
                      Text(comment.content),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => onLike,
                        child: Text('Like',
                            style: AppTypography.labelSmall
                                .copyWith(color: AppColors.darkGray)),
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: () => onReply(comment.user.name),
                        child: Text('Reply',
                            style: AppTypography.labelSmall
                                .copyWith(color: AppColors.darkGray)),
                      ),
                      const SizedBox(width: 15),
                      Flexible(
                        child: Text(
                          timeago.format(comment.timestamp),
                          style: AppTypography.bodySmall
                              .copyWith(color: AppColors.darkGray),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                if (comment.replies.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: Column(
                      children: comment.replies
                          .map((reply) => CommentCard(
                                comment: reply,
                                currentUserId: currentUserId,
                                onReply: onReply,
                                onLike: onLike,
                              ))
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

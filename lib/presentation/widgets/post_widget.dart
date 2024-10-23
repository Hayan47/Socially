import 'package:flutter/material.dart';
import 'package:socially/data/models/post_model.dart';
import 'package:socially/presentation/themes/app_colors.dart';
import 'package:socially/presentation/themes/app_typography.dart';
import 'package:socially/presentation/widgets/comment_dialog.dart';
import 'package:socially/presentation/widgets/post_image_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final isBigWidth = MediaQuery.sizeOf(context).width > 600;
    return Container(
      margin: isBigWidth
          ? const EdgeInsets.symmetric(horizontal: 20, vertical: 8)
          : const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isBigWidth ? AppColors.lightGray : AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: isBigWidth ? 17.5 : 12.5,
                  backgroundImage: AssetImage(post.user.avatarUrl)),
              const SizedBox(width: 8.5),
              Text(
                post.user.name,
                style: AppTypography.labelLarge
                    .copyWith(color: AppColors.darkGray),
              ),
              const Spacer(),
              Text(
                timeago.format(post.timestamp),
                style: AppTypography.labelMedium
                    .copyWith(color: AppColors.darkBlueTransparent),
              ),
              const SizedBox(width: 8.5),
              isBigWidth
                  ? Image.asset('assets/icons/bookmark.png')
                  : Container()
            ],
          ),
          //! Post's Images
          PostImage(imagesUrls: post.imageUrls),
          const SizedBox(height: 12),
          Text(
            post.content,
            style: AppTypography.bodyLarge.copyWith(color: AppColors.darkGray),
          ),
          const SizedBox(height: 12),
          post.imageUrls.isEmpty
              ? const Divider(color: AppColors.darkBlueTransparent)
              : Container(),
          Row(
            children: [
              Image.asset('assets/icons/like_lite.png'),
              const SizedBox(width: 4),
              Text(
                post.likes.toString(),
                style: AppTypography.labelMedium
                    .copyWith(color: AppColors.darkGray),
              ),
              const SizedBox(width: 16),
              GestureDetector(onTap: () {
                if (isBigWidth) {
                  showDialog(
                    context: context,
                    useSafeArea: false,
                    builder: (context) => CommentsDialog(post: post),
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    'commentspage',
                    arguments: post,
                  );
                }
              }),
              const SizedBox(width: 4),
              Text(
                post.comments.length.toString(),
                style: AppTypography.labelMedium
                    .copyWith(color: AppColors.darkGray),
              ),
              const Spacer(),
              isBigWidth
                  ? Container()
                  : Image.asset('assets/icons/bookmark.png'),
            ],
          ),
        ],
      ),
    );
  }
}

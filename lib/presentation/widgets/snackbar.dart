import 'package:flutter/material.dart';
import 'package:socially/presentation/themes/app_colors.dart';
import 'package:socially/presentation/themes/app_typography.dart';

class MySnackBar extends SnackBar {
  MySnackBar({
    super.key,
    required Icon icon,
    required String message,
  }) : super(
          content: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.navyBlue,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 10),
                Expanded(
                  child: Text(message,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.white)),
                ),
              ],
            ),
          ),
          // margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          elevation: 0,
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.transparent,
          // behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
}

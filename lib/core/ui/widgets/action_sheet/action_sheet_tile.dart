import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';

class ActionSheetTile extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final BorderRadius? borderRadius;
  final VoidCallback onTap;

  const ActionSheetTile({
    super.key,
    required this.title,
    this.titleColor,
    this.borderRadius,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius,
      color: AppColors.grayscale800,
      child: InkWell(
        borderRadius: borderRadius,
        splashColor:
            Platform.isAndroid ? AppColors.grayscale600 : Colors.transparent,
        highlightColor: AppColors.grayscale600,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          height: 54.0,
          decoration: BoxDecoration(borderRadius: borderRadius),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.body1Medium16pt.copyWith(
                color: titleColor ?? AppColors.grayscale100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

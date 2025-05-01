import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/ui.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(24.0);

    return Material(
      color: AppColors.grayscale100,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        splashColor:
            Platform.isAndroid ? AppColors.grayscale600 : Colors.transparent,
        highlightColor: AppColors.grayscale600,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(24.0),

          height: 76.0,
          decoration: BoxDecoration(borderRadius: borderRadius),
          child: Text(title, style: AppTextStyles.headline1Semibold20pt),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/ui.dart';

class DeskTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const DeskTile({super.key, required this.title, required this.onTap});

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
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: [BoxShadow(color: AppColors.shadow1, blurRadius: 60.0)],
          ),
          child: Text(title, style: AppTextStyles.headline1Semibold20pt),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list_app/core/ui/theme/theme.dart';

class PlusButton extends StatelessWidget {
  final VoidCallback onTap;

  const PlusButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const height = 65.0;
    final borderRadius = BorderRadius.circular(height / 2.0);

    return Material(
      color: AppColors.grayscale800,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        splashColor:
            Platform.isAndroid ? AppColors.grayscale600 : Colors.transparent,
        highlightColor: AppColors.grayscale600,
        onTap: onTap,
        child: Container(
          width: height,
          height: height,
          decoration: BoxDecoration(borderRadius: borderRadius),
          child: Center(child: SvgPicture.asset(AppIcons.plus)),
        ),
      ),
    );
  }
}

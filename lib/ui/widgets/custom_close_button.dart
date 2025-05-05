import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list_app/ui/ui.dart';

class CustomCloseButton extends StatelessWidget {
  final VoidCallback onTap;
  const CustomCloseButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const height = 32.0;
    final borderRadius = BorderRadius.circular(height / 2.0);

    return Material(
      borderRadius: borderRadius,
      color: AppColors.grayscale100,
      child: InkWell(
        borderRadius: borderRadius,
        splashColor:
            Platform.isAndroid ? AppColors.grayscale600 : Colors.transparent,
        highlightColor: AppColors.grayscale600,
        onTap: onTap,
        child: Container(
          width: height,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: AppColors.grayscale400,
          ),
          child: Center(child: SvgPicture.asset(AppIcons.close)),
        ),
      ),
    );
  }
}

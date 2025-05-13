import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list_app/core/core.dart';

class ActionButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;

  const ActionButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const height = 42.0;
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
            boxShadow: [BoxShadow(color: AppColors.shadow1, blurRadius: 60.0)],
          ),
          child: Center(child: SvgPicture.asset(icon)),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/ui.dart';

class SecondaryButton extends StatelessWidget {
  final ButtonState state;
  final String title;
  final VoidCallback onTap;

  const SecondaryButton({
    super.key,
    this.state = ButtonState.initial,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color =
        state == ButtonState.pressed
            ? AppColors.grayscale600
            : AppColors.grayscale300;

    final Widget child =
        state == ButtonState.loading
            ? LoadingIndicator(state: LoadingIndicatorState.mediumDark)
            : Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.body1Medium16pt.copyWith(
                color:
                    state == ButtonState.disabled
                        ? AppColors.grayscale600
                        : AppColors.grayscale800,
              ),
            );

    final BorderRadius borderRadius = BorderRadius.circular(18.0);

    return Material(
      color: color,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        splashColor:
            Platform.isAndroid ? AppColors.grayscale600 : Colors.transparent,
        highlightColor: AppColors.grayscale600,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          width: 147.0,
          height: 46.0,
          decoration: BoxDecoration(color: color, borderRadius: borderRadius),
          child: Center(child: child),
        ),
      ),
    );
  }
}

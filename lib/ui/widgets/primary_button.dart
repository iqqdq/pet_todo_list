import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/ui.dart';

enum PrimaryButtonSize { small, medium, large }

class PrimaryButton extends StatelessWidget {
  final PrimaryButtonSize size;
  final ButtonState state;
  final String title;
  final VoidCallback onTap;

  const PrimaryButton({
    super.key,
    this.size = PrimaryButtonSize.large,
    this.state = ButtonState.initial,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double width =
        size == PrimaryButtonSize.small
            ? 147.0
            : size == PrimaryButtonSize.medium
            ? 295.0
            : double.infinity;

    final double height = size == PrimaryButtonSize.small ? 46.0 : 54.0;

    final Color color =
        state == ButtonState.pressed
            ? AppColors.grayscale700
            : state == ButtonState.disabled
            ? AppColors.grayscale500
            : AppColors.grayscale800;

    final Widget child =
        state == ButtonState.loading
            ? LoadingIndicator(state: LoadingIndicatorState.mediumWhite)
            : Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.body1Medium16pt.copyWith(
                color:
                    state == ButtonState.exit
                        ? AppColors.error
                        : AppColors.grayscale100,
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
        onTap: state == ButtonState.disabled ? null : onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          width: width,
          height: height,
          decoration: BoxDecoration(borderRadius: borderRadius),
          child: Center(child: child),
        ),
      ),
    );
  }
}

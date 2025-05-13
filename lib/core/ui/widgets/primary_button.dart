import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';

enum PrimaryButtonState { initial, loading, pressed, disabled, exit }

class PrimaryButton extends StatelessWidget {
  final PrimaryButtonState state;
  final String title;
  final VoidCallback onTap;

  const PrimaryButton({
    super.key,
    this.state = PrimaryButtonState.initial,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color =
        state == PrimaryButtonState.pressed
            ? AppColors.grayscale700
            : state == PrimaryButtonState.disabled
            ? AppColors.grayscale500
            : AppColors.grayscale800;

    final Widget child =
        state == PrimaryButtonState.loading
            ? LoadingIndicator(state: LoadingIndicatorState.white)
            : Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.body1Medium16pt.copyWith(
                color:
                    state == PrimaryButtonState.exit
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
        onTap: state == PrimaryButtonState.initial ? onTap : null,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          width: double.infinity,
          height: 54.0,
          decoration: BoxDecoration(borderRadius: borderRadius),
          child: Center(child: child),
        ),
      ),
    );
  }
}

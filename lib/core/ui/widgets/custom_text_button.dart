import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomTextButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.error;
          }

          if (states.contains(WidgetState.disabled)) {
            return AppColors.grayscale600;
          }

          return AppColors.orangeIndicator;
        }),
      ),
      child: Text(title, style: AppTextStyles.body1Medium16pt),
    );
  }
}

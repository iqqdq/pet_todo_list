import 'package:flutter/cupertino.dart';
import 'package:todo_list_app/ui/ui.dart';

class RichTextButton extends StatelessWidget {
  final String title;
  final String span;
  final VoidCallback onPressed;

  const RichTextButton({
    super.key,
    required this.title,
    required this.span,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: title,
              style: AppTextStyles.body1Medium16pt.copyWith(
                color: AppColors.grayscale700,
              ),
            ),
            TextSpan(
              text: span,
              style: AppTextStyles.body1Medium16pt.copyWith(
                color: AppColors.orangeIndicator,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

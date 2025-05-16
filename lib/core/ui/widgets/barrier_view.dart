import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';

class BarrierView extends StatelessWidget {
  const BarrierView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: AppColors.grayscale800.withValues(alpha: 0.9),
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

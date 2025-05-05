import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list_app/ui/ui.dart';

class TaskCheckbox extends StatelessWidget {
  final bool status;

  const TaskCheckbox({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        color: status ? AppColors.grayscale800 : null,
        border: Border.all(width: 1.0, color: AppColors.grayscale800),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child:
            status
                ? SvgPicture.asset(
                  AppIcons.check,
                  colorFilter: ColorFilter.mode(
                    AppColors.grayscale100,
                    BlendMode.srcIn,
                  ),
                )
                : SizedBox.shrink(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list_app/ui/ui.dart';

class NavigationTab extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const NavigationTab({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color =
        isSelected ? AppColors.grayscale800 : AppColors.grayscale600;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 4.0),
          width: 90.0,
          color: AppColors.grayscale100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              SizedBox(height: 4.0),
              Text(
                title,
                style: AppTextStyles.caption1Regular12pt.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

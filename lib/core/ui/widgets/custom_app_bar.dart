import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onLogoutTap;

  const CustomAppBar({super.key, required this.title, this.onLogoutTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: AppColors.grayscale200,
      automaticallyImplyLeading: false,
      centerTitle: onLogoutTap == null,
      actionsPadding: EdgeInsets.symmetric(horizontal: 16.0),
      leading:
          onLogoutTap == null
              ? Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Center(
                  child: ActionButton(
                    icon: AppIcons.back,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              )
              : null,
      leadingWidth: 58.0,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style:
            onLogoutTap == null
                ? AppTextStyles.headline1Semibold20pt
                : AppTextStyles.title2SemiBold28pt,
      ),
      actions:
          onLogoutTap == null
              ? null
              : [ActionButton(icon: AppIcons.exit, onTap: onLogoutTap!)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(78.0);
}

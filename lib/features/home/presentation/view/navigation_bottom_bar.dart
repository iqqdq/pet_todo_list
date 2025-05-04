import 'package:flutter/cupertino.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/ui/ui.dart';
import 'view.dart';

class NavigationBottomBar extends StatefulWidget {
  final Function(int) onPressed;

  const NavigationBottomBar({super.key, required this.onPressed});

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int current = 0; // TODO CHANGE NOTIFIER?

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 12.0,
      ).copyWith(bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: AppColors.grayscale100,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [BoxShadow(color: AppColors.shadow1, blurRadius: 60.0)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _tab(icon: AppIcons.myDesk, title: AppTitles.myDesk, index: 0),
          _tab(
            icon: AppIcons.usersDesks,
            title: AppTitles.usersDesks,
            index: 1,
          ),
          _tab(icon: AppIcons.subscribers, title: AppTitles.followed, index: 2),
        ],
      ),
    );
  }

  Widget _tab({
    required String icon,
    required String title,
    required int index,
  }) => NavigationTab(
    icon: icon,
    title: title,
    isSelected: index == current,
    onTap: () => setState(() => current = index),
  );
}

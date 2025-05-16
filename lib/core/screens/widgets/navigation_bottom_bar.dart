import 'package:flutter/cupertino.dart';
import 'package:todo_list_app/core/core.dart';

class NavigationBottomBar extends StatefulWidget {
  final Function(int) onPressed;

  const NavigationBottomBar({super.key, required this.onPressed});

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 71.0 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 12.0,
      ).copyWith(bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: AppColors.grayscale100,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        boxShadow: [BoxShadow(color: AppColors.shadow1, blurRadius: 60.0)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NavigationTab(
            icon: AppIcons.myDesk,
            title: AppTitles.myDesk,
            isSelected: _current == 0,
            onTap: () => _onTabPressed(0),
          ),
          NavigationTab(
            icon: AppIcons.usersDesks,
            title: AppTitles.usersDesks,
            isSelected: _current == 1,
            onTap: () => _onTabPressed(1),
          ),
          NavigationTab(
            icon: AppIcons.subscribers,
            title: AppTitles.followed,
            isSelected: _current == 2,
            onTap: () => _onTabPressed(2),
          ),
        ],
      ),
    );
  }

  // MARK: -
  // MARK: - FUNCTION'S

  void _onTabPressed(int index) => {
    setState(() => _current = index),
    widget.onPressed(_current),
  };
}

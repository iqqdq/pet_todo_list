import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';

class ActionSheetDialog {
  static void show(
    BuildContext context, {
    required String title,
    required List<SheetAction> actions,
    Duration animationDuration = const Duration(milliseconds: 300),
    required Function(int index) onTap,
  }) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      transitionDuration: animationDuration,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, animation1, animation2, widget) {
        final fadeAnimation = CurvedAnimation(
          parent: animation1,
          curve: Curves.easeInOut,
        );

        final slideAnimation = Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation1, curve: Curves.easeInOut));

        return Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              FadeTransition(opacity: fadeAnimation, child: BarrierView()),

              SlideTransition(
                position: slideAnimation,
                child: ActionSheetView(
                  title: title,
                  actions: actions,
                  onTap: onTap,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

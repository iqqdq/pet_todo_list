import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';

class InputSheetDialog {
  static void show(
    BuildContext context, {
    required String title,
    required String hintText,
    required Function(String text) onEditingComplete,
    String? text,
    Duration animationDuration = const Duration(milliseconds: 300),
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

        return Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              FadeTransition(opacity: fadeAnimation, child: BarrierView()),

              FadeTransition(
                opacity: fadeAnimation,
                child: InputSheetView(
                  title: title,
                  text: text,
                  hintText: hintText,
                  onEditingComplete: onEditingComplete,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

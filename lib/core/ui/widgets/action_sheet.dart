import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';

class SheetAction {
  final String title;
  final bool isDestructive;

  SheetAction({required this.title, this.isDestructive = false});
}

class ActionSheet {
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

        final divider = Divider(
          height: AppSpacing.spacing05px,
          color: AppColors.grayscale700,
        );

        final radius = 18.0;

        return Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              FadeTransition(
                opacity: fadeAnimation,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    color: AppColors.grayscale800.withValues(alpha: 0.9),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              SlideTransition(
                position: slideAnimation,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              /// TITLE
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 18.0,
                                    ),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.grayscale800,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(radius),
                                        topRight: Radius.circular(radius),
                                      ),
                                    ),
                                    child: Text(
                                      title,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.body4Regular14pt
                                          .copyWith(
                                            color: AppColors.grayscale700,
                                          ),
                                    ),
                                  ),
                                  divider,
                                ],
                              ),

                              /// ACTION LIST VIEW
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: actions.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        divider,
                                itemBuilder: (BuildContext context, int index) {
                                  return ActionTile(
                                    title: actions[index].title,
                                    titleColor:
                                        actions[index].isDestructive
                                            ? AppColors.error
                                            : null,
                                    borderRadius:
                                        index == actions.length - 1
                                            ? BorderRadius.only(
                                              bottomLeft: Radius.circular(
                                                radius,
                                              ),
                                              bottomRight: Radius.circular(
                                                radius,
                                              ),
                                            )
                                            : null,
                                    onTap:
                                        () => {
                                          Navigator.pop(context),
                                          onTap(index),
                                        },
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          ActionTile(
                            title: AppTitles.cancel,
                            borderRadius: BorderRadius.circular(radius),
                            onTap: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ActionTile extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final BorderRadius? borderRadius;
  final VoidCallback onTap;

  const ActionTile({
    super.key,
    required this.title,
    this.titleColor,
    this.borderRadius,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius,
      color: AppColors.grayscale800,
      child: InkWell(
        borderRadius: borderRadius,
        splashColor:
            Platform.isAndroid ? AppColors.grayscale600 : Colors.transparent,
        highlightColor: AppColors.grayscale600,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          height: 54.0,
          decoration: BoxDecoration(borderRadius: borderRadius),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.body1Medium16pt.copyWith(
                color: titleColor ?? AppColors.grayscale100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

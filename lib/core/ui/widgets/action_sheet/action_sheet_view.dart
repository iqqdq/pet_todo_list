import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';

class ActionSheetView extends StatelessWidget {
  final String title;
  final List<SheetAction> actions;
  final Function(int index) onTap;

  const ActionSheetView({
    super.key,
    required this.title,
    required this.actions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final divider = Divider(
      height: AppSpacing.spacing05px,
      color: AppColors.grayscale700,
    );

    final radius = 18.0;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
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
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(radius),
                          ),
                        ),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body4Regular14pt.copyWith(
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
                        (BuildContext context, int index) => divider,
                    itemBuilder: (BuildContext context, int index) {
                      return ActionSheetTile(
                        title: actions[index].title,
                        titleColor:
                            actions[index].isDestructive
                                ? AppColors.error
                                : null,
                        borderRadius:
                            index == actions.length - 1
                                ? BorderRadius.vertical(
                                  bottom: Radius.circular(radius),
                                )
                                : null,
                        onTap: () => {Navigator.pop(context), onTap(index)},
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              ActionSheetTile(
                title: AppTitles.cancel,
                borderRadius: BorderRadius.circular(radius),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_list_app/core/constants/app_titles.dart';
import 'package:todo_list_app/features/features.dart';
import 'package:todo_list_app/ui/ui.dart';

class DeskListView extends StatelessWidget {
  final List<DeskEntity> desks;
  final Function(int index) onTap;
  final Function(int index) onEditPressed;
  final Function(int index) onDeletePressed;

  const DeskListView({
    super.key,
    required this.desks,
    required this.onTap,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return desks.isEmpty
        ? EmptyListView(title: AppTitles.youHaventCreatedAnyColumn)
        :
        /// BACKGROUND IMAGE
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            image: DecorationImage(
              image: AssetImage(AppImages.abstractBackgroundImage),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: ClipRRect(
            child:
            /// LIST VIEW
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              itemCount: desks.length,
              separatorBuilder:
                  (BuildContext context, int index) =>
                      SizedBox(height: AppSpacing.spacing12px),
              itemBuilder: (BuildContext context, int index) {
                final desk = desks[index];

                return Slidable(
                  index: index,
                  onEditPressed: onEditPressed,
                  onDeletePressed: onDeletePressed,
                  child: DeskTile(
                    key: ValueKey(desk.id),
                    title: desk.name,
                    onTap: () => onTap(index),
                  ),
                );
              },
            ),
          ),
        );
  }
}

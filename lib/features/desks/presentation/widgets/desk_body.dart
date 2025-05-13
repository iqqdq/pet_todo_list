import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/features.dart';

class DesksBody extends StatelessWidget {
  final List<DeskEntity> desks;
  final Function(int index) onTap;
  final Function(int index, String title) onChanged;
  final Function(int index) onDeletePressed;

  const DesksBody({
    super.key,
    required this.desks,
    required this.onTap,
    required this.onChanged,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    List<Item> items = desks.map((desk) => Item(text: desk.name)).toList();

    return desks.isEmpty
        ? EmptyListView(title: AppTitles.youHaventCreatedAnyColumn)
        :
        /// BACKGROUND IMAGE
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              margin: EdgeInsets.all(16.0),
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
                OverlayListView(
                  items: items,
                  onTap: onTap,
                  onChanged: onChanged,
                  onDeletePressed: onDeletePressed,
                ),
              ),
            );
          },
        );
  }
}

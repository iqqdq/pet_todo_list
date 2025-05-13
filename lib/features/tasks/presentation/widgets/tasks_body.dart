import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/features.dart';

class TasksBody extends StatelessWidget {
  final List<TaskEntity> tasks;
  final Function(int index) onTap;
  final Function(int index, String value) onChanged;
  final Function(int index) onDeletePressed;

  const TasksBody({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onChanged,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    List<Item> items =
        tasks
            .map((task) => Item(text: task.name, status: task.status))
            .toList();

    return tasks.isEmpty
        ? EmptyListView(title: AppTitles.youHaventCreatedAnyTask)
        : OverlayListView(
          bottomPadding: 140.0,
          items: items,
          onTap: onTap,
          onChanged: onChanged,
          onDeletePressed: onDeletePressed,
        );
  }
}

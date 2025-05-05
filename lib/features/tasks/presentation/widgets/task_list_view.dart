import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/features.dart';
import 'package:todo_list_app/ui/ui.dart';

class TaskListView extends StatelessWidget {
  final List<TaskEntity> tasks;
  final Function(int index) onTap;
  final Function(int index) onEditPressed;
  final Function(int index) onDeletePressed;

  const TaskListView({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? EmptyListView(title: AppTitles.youHaventCreatedAnyTask)
        : ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ).copyWith(bottom: 124.0),
          itemCount: tasks.length,
          separatorBuilder:
              (BuildContext context, int index) =>
                  SizedBox(height: AppSpacing.spacing12px),
          itemBuilder: (BuildContext context, int index) {
            final task = tasks[index];

            return Slidable(
              index: index,
              onEditPressed: onEditPressed,
              onDeletePressed: onDeletePressed,
              child: TaskTile(
                key: ValueKey(task.id),
                title: task.name,
                status: task.status,
                onTap: () => onTap(index),
              ),
            );
          },
        );
  }
}

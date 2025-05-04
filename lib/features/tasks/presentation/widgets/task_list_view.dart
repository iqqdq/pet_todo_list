import 'package:flutter/material.dart';
import 'package:todo_list_app/features/features.dart';
import 'package:todo_list_app/ui/ui.dart';

class TaskListView extends StatelessWidget {
  final List<TaskEntity> tasks;
  final Function(int index) onTap;

  const TaskListView({super.key, required this.tasks, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(child: Text('EMPTY LIST'))
        : ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ).copyWith(bottom: 124.0),
          itemCount: tasks.length,
          separatorBuilder:
              (BuildContext context, int index) =>
                  SizedBox(height: AppSpacing.spacing12px),
          itemBuilder: (BuildContext context, int index) {
            return TaskTile(
              title: tasks[index].name,
              status: tasks[index].status,
              onTap: () => onTap(index),
            );
          },
        );
  }
}

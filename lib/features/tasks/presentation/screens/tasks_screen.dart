import 'package:flutter/material.dart';
import 'package:todo_list_app/features/features.dart';
import 'package:todo_list_app/ui/ui.dart';

class TasksScreen extends StatefulWidget {
  final DeskEntity desk;

  const TasksScreen({super.key, required this.desk});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late final TasksChangeNotifier tasksChangeNotifier;

  @override
  void initState() {
    tasksChangeNotifier = TasksChangeNotifier(deskId: widget.desk.id)
      ..getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.desk.name),
      backgroundColor: AppColors.grayscale200,
      body: SizedBox.expand(
        child: Stack(
          children: [
            /// LIST VIEW
            ListenableBuilder(
              listenable: tasksChangeNotifier,
              builder: (context, _) {
                return TaskListView(
                  tasks: tasksChangeNotifier.tasks,
                  onTap:
                      (index) =>
                          _onTaskPresssed(tasksChangeNotifier.tasks[index]),
                );
              },
            ),

            /// ADD BUTTON
            Positioned(
              right: 16.0,
              bottom: MediaQuery.of(context).padding.bottom + 12.0,
              child: PlusButton(onTap: _onPlusPressed),
            ),
          ],
        ),
      ),
    );
  }

  // MARK: -
  // MARK: - FUNCTION'S

  void _onPlusPressed() => {
    tasksChangeNotifier.addTask(name: '1').whenComplete(() {
      if (tasksChangeNotifier.error != null && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(tasksChangeNotifier.error!)));
      }
    }),
  };

  void _onTaskPresssed(TaskEntity task) => {
    tasksChangeNotifier.setTaskStatus(deskId: widget.desk.id, task: task),
  };

  void _onTaskUpdatePresssed(TaskEntity task, String name) =>
      tasksChangeNotifier.updateTask(
        deskId: widget.desk.id,
        task: task.copyWith(name: name),
      );

  void _onTaskDeletePressed(String id) =>
      tasksChangeNotifier.deleteTask(deskId: widget.desk.id, id: id);
}

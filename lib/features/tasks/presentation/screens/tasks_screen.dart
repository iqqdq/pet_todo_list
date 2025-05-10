import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';
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
      resizeToAvoidBottomInset: false,
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
                  onTap: _onTaskPresssed,
                  onEditPressed: _onEditPresssed,
                  onDeletePressed: _onDeletePressed,
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

  void _onPlusPressed() => InputSheet.show(
    context,
    title: AppTitles.newTask,
    hintText: AppTitles.enterTitleOfTask,
    onEditingComplete:
        (text) => tasksChangeNotifier.addTask(name: text).whenComplete(() {
          if (tasksChangeNotifier.state == ScreenStateEnum.error && mounted) {
            _showErrorAlert();
          }
        }),
  );

  void _onTaskPresssed(int index) => tasksChangeNotifier.updateTask(
    deskId: widget.desk.id,
    task: tasksChangeNotifier.tasks[index].copyWith(
      status: !tasksChangeNotifier.tasks[index].status,
    ),
  );

  void _onEditPresssed(int index) => InputSheet.show(
    context,
    title: AppTitles.newName,
    text: tasksChangeNotifier.tasks[index].name,
    hintText: AppTitles.enterNewName,
    onEditingComplete:
        (text) => tasksChangeNotifier.updateTask(
          deskId: widget.desk.id,
          task: tasksChangeNotifier.tasks[index].copyWith(name: text),
        ),
  );

  void _onDeletePressed(int index) => tasksChangeNotifier.deleteTask(
    deskId: widget.desk.id,
    id: tasksChangeNotifier.tasks[index].id,
  );

  void _showErrorAlert() => ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text(AppTitles.taskWithThisNameAlreadyExists)),
  );
}

import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/features.dart';

class TasksScreen extends StatefulWidget {
  final DeskEntity desk;

  const TasksScreen({super.key, required this.desk});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late final TasksChangeNotifier _tasksChangeNotifier;

  @override
  void initState() {
    _tasksChangeNotifier = TasksChangeNotifier(deskId: widget.desk.id)
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
              listenable: _tasksChangeNotifier,
              builder: (context, _) {
                return TasksBody(
                  tasks: _tasksChangeNotifier.tasks,
                  onTap: _onTaskPresssed,
                  onChanged: _onUpdate,
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

  void _onPlusPressed() => InputSheetDialog.show(
    context,
    title: AppTitles.newTask,
    hintText: AppTitles.enterTitleOfTask,
    onEditingComplete:
        (text) => _tasksChangeNotifier.addTask(name: text).whenComplete(() {
          if (_tasksChangeNotifier.state == ScreenStateEnum.error && mounted) {
            _showErrorAlert();
          }
        }),
  );

  void _onTaskPresssed(int index) => _tasksChangeNotifier.updateTask(
    deskId: widget.desk.id,
    task: _tasksChangeNotifier.tasks[index].copyWith(
      status: !_tasksChangeNotifier.tasks[index].status,
    ),
  );

  void _onDeletePressed(int index) => _tasksChangeNotifier.deleteTask(
    deskId: widget.desk.id,
    id: _tasksChangeNotifier.tasks[index].id,
  );

  void _showErrorAlert() => ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text(AppTitles.taskWithThisNameAlreadyExists)),
  );

  void _onUpdate(int index, String value) {
    if (value.isNotEmpty) {
      _tasksChangeNotifier
          .updateTask(
            deskId: widget.desk.id,
            task: _tasksChangeNotifier.tasks[index].copyWith(name: value),
          )
          .whenComplete(() {
            if (_tasksChangeNotifier.state == ScreenStateEnum.error &&
                mounted) {
              _showErrorAlert();
            }
          });
    }
  }
}

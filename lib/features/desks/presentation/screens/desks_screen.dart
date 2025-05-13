import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/features.dart';

class DesksScreen extends StatefulWidget {
  const DesksScreen({super.key});

  @override
  State<DesksScreen> createState() => _DesksScreenState();
}

class _DesksScreenState extends State<DesksScreen> {
  final _desksChangeNotifier = DesksChangeNotifier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.grayscale200,
      body: Stack(
        children: [
          /// LIST VIEW
          Padding(
            padding: EdgeInsets.only(bottom: 72.0),
            child: ListenableBuilder(
              listenable: _desksChangeNotifier,
              builder: (context, _) {
                return _desksChangeNotifier.state == ScreenStateEnum.initial
                    ? Center(child: LoadingIndicator())
                    : DesksBody(
                      desks: _desksChangeNotifier.desks,
                      onTap: _onDeskPresssed,
                      onChanged: _onUpdate,
                      onDeletePressed: _onDeletePressed,
                    );
              },
            ),
          ),

          /// ADD BUTTON
          Positioned(
            right: 16.0,
            bottom: 12.0,
            child: PlusButton(onTap: _onPlusPressed),
          ),
        ],
      ),
    );
  }

  // MARK: -
  // MARK: - FUNCTION'S

  void _onPlusPressed() => InputSheet.show(
    context,
    title: AppTitles.newColumn,
    hintText: AppTitles.enterTitleOfColumn,
    onEditingComplete:
        (text) => _desksChangeNotifier.addDesk(name: text).whenComplete(() {
          if (_desksChangeNotifier.state == ScreenStateEnum.error && mounted) {
            _showErrorAlert();
          }
        }),
  );

  void _onDeskPresssed(int index) => Navigator.push(
    context,
    MaterialPageRoute(
      builder:
          (context) => TasksScreen(desk: _desksChangeNotifier.desks[index]),
    ),
  );

  void _onDeletePressed(int index) =>
      _desksChangeNotifier.deleteDesk(id: _desksChangeNotifier.desks[index].id);

  void _showErrorAlert() => ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text(AppTitles.taskWithThisNameAlreadyExists)),
  );

  void _onUpdate(int index, String value) {
    if (value.isNotEmpty) {
      _desksChangeNotifier.updateDesk(
        desk: _desksChangeNotifier.desks[index].copyWith(name: value),
      );
    }
  }
}

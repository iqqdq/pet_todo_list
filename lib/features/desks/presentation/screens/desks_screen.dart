import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/features.dart';
import 'package:todo_list_app/ui/ui.dart';

class DesksScreen extends StatefulWidget {
  const DesksScreen({super.key});

  @override
  State<DesksScreen> createState() => _DesksScreenState();
}

class _DesksScreenState extends State<DesksScreen> {
  final desksChangeNotifier = DesksChangeNotifier()..getDesks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppTitles.myDesk,
        onLogoutTap: _onLogoutPressed,
      ),
      backgroundColor: AppColors.grayscale200,
      body: SizedBox.expand(
        child: Stack(
          children: [
            /// LIST VIEW
            ListenableBuilder(
              listenable: desksChangeNotifier,
              builder: (context, _) {
                return DeskListView(
                  desks: desksChangeNotifier.desks,
                  onTap:
                      (index) =>
                          _onDeskPresssed(desksChangeNotifier.desks[index]),
                );
              },
            ),

            /// ADD BUTTON
            Positioned(
              right: 16.0,
              bottom: 12.0,
              child: PlusButton(onTap: _onPlusPressed),
            ),
          ],
        ),
      ),
    );
  }

  // MARK: -
  // MARK: - FUNCTION'S

  void _onLogoutPressed() => ActionSheet.show(
    context,
    title: AppTitles.areYouSureYouWantToLogOut,
    actions: [SheetAction(title: AppTitles.logout, isDestructive: true)],
    onTap: (index) => Navigator.pushReplacementNamed(context, '/'),
  );

  void _onPlusPressed() =>
      desksChangeNotifier.addDesk(name: '1').whenComplete(() {
        if (desksChangeNotifier.error != null && mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(desksChangeNotifier.error!)));
        }
      });

  void _onDeskPresssed(DeskEntity desk) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => TasksScreen(desk: desk)),
  );

  // void _onDeskDeletePressed(int index) => {
  // TODO SWIPE TO DELETE
  // };
}

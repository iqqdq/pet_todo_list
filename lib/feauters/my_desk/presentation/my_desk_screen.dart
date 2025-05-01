import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/ui/ui.dart';

import 'view/view.dart';

class MyDeskScreen extends StatefulWidget {
  const MyDeskScreen({super.key});

  @override
  State<MyDeskScreen> createState() => _MyDeskScreenState();
}

class _MyDeskScreenState extends State<MyDeskScreen> {
  final titles = [
    AppTitles.forFamily,
    AppTitles.forLuck,
    AppTitles.forHealth,
    AppTitles.forDeparted,
  ];

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
            MyDeskListView(
              titles: titles,
              onTap: (index) => _onDeskPresssed(index),
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

  void _onPlusPressed() => Navigator.pushReplacementNamed(context, '/');

  void _onDeskPresssed(int index) => {
    // TODO OPEN DESK
  };

  void _onDeskDeletePressed(int index) => {
    // TODO SWIPE TO DELETE
  };
}

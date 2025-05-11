import 'package:flutter/material.dart';
import 'package:todo_list_app/core/di/di.dart';
import 'package:todo_list_app/features/features.dart';
import 'package:todo_list_app/screens/screens.dart';
import 'package:todo_list_app/ui/widgets/widgets.dart';

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
        future: sl.get<AuthRepository>().getCurrentUser().then(
          (user) => user == null,
        ),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: LoadingIndicator());
          }

          return snapshot.data == true ? LogInScreen() : HomeScreen();
        },
      ),
    );
  }
}

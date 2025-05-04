import 'package:flutter/material.dart';
import 'package:todo_list_app/features/features.dart';

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // '/': (context) => SplashScreen(),
        '/home': (context) => const HomeScreen(),
      },
      initialRoute: '/home',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_list_app/feauters/feauters.dart';

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {'/': (context) => const HomeScreen()},
      // initialRoute: '/',
      routes: {'/home': (context) => const HomeScreen()},
      initialRoute: '/home',
    );
  }
}

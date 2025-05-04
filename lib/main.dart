import 'package:flutter/material.dart';
import 'package:todo_list_app/core/di/di.dart';
import 'package:todo_list_app/app/to_do_list_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjections();
  runApp(const ToDoListApp());
}

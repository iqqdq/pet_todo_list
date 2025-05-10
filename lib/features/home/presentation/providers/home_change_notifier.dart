import 'package:flutter/foundation.dart';
import 'package:todo_list_app/core/di/di.dart';
import 'package:todo_list_app/features/home/domain/domain.dart';

class HomeChangeNotifier with ChangeNotifier {
  Future logOut() async => await sl.get<LogOutUsecase>().call();
}

import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/core/di/di.dart';
import 'package:todo_list_app/features/desks/domain/domain.dart';

class DesksChangeNotifier with ChangeNotifier {
  final List<DeskEntity> _desks = [];
  List<DeskEntity> get desks => _desks;

  String? _error;
  String? get error => _error;

  Future getDesks() async {
    final desks = await sl.get<GetDesksUsecase>().call();
    if (desks == null) return;
    _desks.addAll(desks);
    notifyListeners();
  }

  Future addDesk({required String name}) async {
    final desk = await sl.get<AddDeskUsecase>().call(name: name);
    desk == null
        ? _error = AppTitles.deskWithOwnNameExistsYet
        : _desks.add(desk);
    notifyListeners();
  }

  Future deleteDesk({required String id}) async {
    await sl.get<DeleteDeskUsecase>().call(id: id);
    _desks.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future updateDesk({required String id, required String name}) async {
    final desk = await sl.get<UpdateDeskUsecase>().call(id: id, name: name);
    final index = _desks.indexWhere((element) => element.name == desk.name);
    _desks[index] = desk;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}

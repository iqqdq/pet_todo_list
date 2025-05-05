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
    _desks.clear();
    _desks.addAll(desks);
    notifyListeners();
  }

  Future addDesk({required String name}) async {
    final desk = await sl.get<AddDeskUsecase>().call(name: name);
    if (desk == null) {
      _error = AppTitles.deskWithOwnNameExistsYet;
      notifyListeners();
    } else {
      getDesks();
    }
  }

  Future deleteDesk({required String id}) async {
    _desks.removeWhere((element) => element.id == id);
    await sl.get<DeleteDeskUsecase>().call(desks: _desks, id: id);
    getDesks();
  }

  Future updateDesk({required DeskEntity desk}) async {
    await sl.get<UpdateDeskUsecase>().call(desk: desk);
    getDesks();
  }
}

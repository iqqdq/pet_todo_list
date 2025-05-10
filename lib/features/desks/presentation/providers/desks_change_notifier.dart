import 'package:flutter/foundation.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/core/di/di.dart';
import 'package:todo_list_app/features/desks/domain/domain.dart';

class DesksChangeNotifier with ChangeNotifier {
  ScreenStateEnum _state = ScreenStateEnum.initial;
  ScreenStateEnum get state => _state;

  final List<DeskEntity> _desks = [];
  List<DeskEntity> get desks => _desks;

  Future getDesks() async {
    final desks = await sl.get<GetDesksUsecase>().call();
    if (desks == null) return;
    _desks.clear();
    _desks.addAll(desks);
    _state = ScreenStateEnum.success;
    notifyListeners();
  }

  Future addDesk({required String name}) async =>
      await sl.get<AddDeskUsecase>().call(name: name).then((value) {
        if (value == null) {
          _state = ScreenStateEnum.error;
          notifyListeners();
        } else {
          getDesks();
        }
      });

  Future deleteDesk({required String id}) async {
    await sl.get<DeleteDeskUsecase>().call(desks: _desks, id: id);
    getDesks();
  }

  Future updateDesk({required DeskEntity desk}) async {
    await sl.get<UpdateDeskUsecase>().call(desk: desk);
    getDesks();
  }
}

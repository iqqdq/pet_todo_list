import 'package:flutter/foundation.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/auth/auth.dart';
import 'package:todo_list_app/features/desks/domain/domain.dart';

class DesksChangeNotifier with ChangeNotifier {
  late final String _userId;

  DesksChangeNotifier() {
    _init();
  }

  ScreenStateEnum _state = ScreenStateEnum.initial;
  ScreenStateEnum get state => _state;

  final List<DeskEntity> _desks = [];

  List<DeskEntity> get desks => _desks;

  void _init() async {
    _userId = (await sl.get<AuthRepository>().getCurrentUser())!.id;
    getDesks();
  }

  Future getDesks() async {
    final desks = await sl.get<GetDesksUsecase>().call(userId: _userId);
    _desks.clear();
    _desks.addAll(desks ?? []);
    _state = ScreenStateEnum.success;
    notifyListeners();
  }

  Future addDesk({required String name}) async => await sl
      .get<AddDeskUsecase>()
      .call(userId: _userId, name: name)
      .then((value) async {
        if (value == null) {
          _state = ScreenStateEnum.error;
          notifyListeners();
        } else {
          await getDesks();
        }
      });

  Future deleteDesk({required String id}) async {
    await sl.get<DeleteDeskUsecase>().call(userId: _userId, id: id);
    getDesks();
  }

  Future updateDesk({required DeskEntity desk}) async {
    await sl.get<UpdateDeskUsecase>().call(userId: _userId, desk: desk);
    getDesks();
  }
}

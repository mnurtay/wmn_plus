import 'package:wmn_plus/features/profile/change_mode/index.dart';

class ChangeModeRepository {
  final ChangeModeProvider _changeModeProvider = ChangeModeProvider();

  ChangeModeRepository();

  void test(bool isError) {
    this._changeModeProvider.test(isError);
  }
}
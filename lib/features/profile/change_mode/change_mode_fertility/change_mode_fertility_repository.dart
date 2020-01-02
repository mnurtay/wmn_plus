import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/index.dart';

class ChangeModeFertilityRepository {
  final ChangeModeFertilityProvider _changeModeFertilityProvider = ChangeModeFertilityProvider();

  ChangeModeFertilityRepository();

  void test(bool isError) {
    this._changeModeFertilityProvider.test(isError);
  }
}
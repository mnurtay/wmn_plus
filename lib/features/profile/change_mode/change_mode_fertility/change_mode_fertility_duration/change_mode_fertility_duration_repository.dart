import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/change_mode_fertility_duration/index.dart';

class ChangeModeFertilityDurationRepository {
  final ChangeModeFertilityDurationProvider _changeModeFertilityDurationProvider = ChangeModeFertilityDurationProvider();

  ChangeModeFertilityDurationRepository();

  void test(bool isError) {
    this._changeModeFertilityDurationProvider.test(isError);
  }
}
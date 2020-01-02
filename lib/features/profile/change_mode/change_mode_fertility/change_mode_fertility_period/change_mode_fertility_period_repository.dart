import 'package:wmn_plus/features/auth/model/User.dart' as Us;
import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/change_mode_fertility_period/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

class ChangeModeFertilityPeriodRepository {
  final ChangeModeFertilityPeriodProvider _changeModeFertilityPeriodProvider = ChangeModeFertilityPeriodProvider();

  ChangeModeFertilityPeriodRepository();

  void test(bool isError) {
    this._changeModeFertilityPeriodProvider.test(isError);
  }

  Future<Us.User> changeFertilityMode(String token, Fertility fertility) => _changeModeFertilityPeriodProvider.requestChangeMode(token, fertility);
}
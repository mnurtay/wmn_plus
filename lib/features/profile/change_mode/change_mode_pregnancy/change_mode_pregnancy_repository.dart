import 'package:wmn_plus/features/auth/model/User.dart' as Us;
import 'package:wmn_plus/features/profile/change_mode/change_mode_pregnancy/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

class ChangeModePregnancyRepository {
  final ChangeModePregnancyProvider _changeModePregnancyProvider = ChangeModePregnancyProvider();

  ChangeModePregnancyRepository();

  void test(bool isError) {
    this._changeModePregnancyProvider.test(isError);
  }

    Future<Us.User> changePregnancyMode(String token, Pregnancy preg) => _changeModePregnancyProvider.requestChangeMode(token, preg);

}
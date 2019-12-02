import 'package:wmn_plus/features/registration/registration_mode/index.dart';

class RegistrationModeRepository {
  final RegistrationModeProvider _registrationModeProvider = RegistrationModeProvider();

  RegistrationModeRepository();

  void test(bool isError) {
    this._registrationModeProvider.test(isError);
  }
}
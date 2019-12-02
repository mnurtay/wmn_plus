import 'package:wmn_plus/features/registration/index.dart';

class RegistrationRepository {
  final RegistrationProvider _registrationProvider = RegistrationProvider();

  RegistrationRepository();

  void test(bool isError) {
    this._registrationProvider.test(isError);
  }
}
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/registration/index.dart';
import 'package:wmn_plus/features/registration/registration_mode/pregnant_mode/index.dart';

class PregnantModeRepository {
  final PregnantModeProvider _pregnantModeProvider = PregnantModeProvider();

  PregnantModeRepository();

  Future<User> requestUserRegistration(RegistrationModel registrationModel) =>
      _pregnantModeProvider.registerUser(registrationModel);

  Future<User> requestUserClimaxRegistration(
          RegistrationModel registrationModel) =>
      _pregnantModeProvider.registerUserClimax(registrationModel);
}

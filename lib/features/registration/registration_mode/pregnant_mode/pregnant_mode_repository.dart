import 'package:wmn_plus/features/registration/index.dart';
import 'package:wmn_plus/features/registration/registration_mode/pregnant_mode/index.dart';

class PregnantModeRepository {
  final PregnantModeProvider _pregnantModeProvider = PregnantModeProvider();

  PregnantModeRepository();

  requestUserRegistration(RegistrationModel registrationModel) =>
      _pregnantModeProvider.registerUser(registrationModel);
}

import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/fertility_period/index.dart';
import 'package:wmn_plus/features/registration/registration_mode/pregnant_mode/pregnant_mode_provider.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';



class FertilityPeriodRepository {
  final FertilityPeriodProvider _fertilityPeriodProvider = FertilityPeriodProvider();
  final PregnantModeProvider _pregnantModeProvider = PregnantModeProvider();

  FertilityPeriodRepository();

  Future<User> requestUserRegistration(RegistrationModel registrationModel) async =>
      await _fertilityPeriodProvider.registerUser(registrationModel);
}
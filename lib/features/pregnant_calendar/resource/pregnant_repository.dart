import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/pregnant_calendar/model/Pregnant.dart';
import 'package:wmn_plus/features/pregnant_calendar/resource/pregnant_api_provider.dart';

class PregnantRepository {
  UserRepository userRepository = UserRepository();
  PregnantApiProvider pregnantApiProvider = PregnantApiProvider();
  final String spKey = 'pregnant_data';

  Future<void> savePregnantData(Pregnant pregnant) async {
    SharedPreferences spInstance = await SharedPreferences.getInstance();
    await spInstance.setString(spKey, pregnant.objectToString());
  }

  Future<Pregnant> getPregnantData() async {
    SharedPreferences spInstance = await SharedPreferences.getInstance();
    final jsonString = spInstance.getString(spKey);
    return Pregnant.parseJson(jsonString);
  }

  Future<Pregnant> fetchPregnant() async {
    final currentUser = await userRepository.getCurrentUser();
    final pregnant =
        await pregnantApiProvider.fetchPrognant(currentUser.result.token);
    await savePregnantData(pregnant);
    return pregnant;
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';

Future<Map<String, String>> getHeaders() async {
  var userRepo = await UserRepository().getCurrentUser();
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    "Authorization": "wmn538179 ${userRepo.result.token}",
  };
  return headers;
}

import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/profile/changeprofile/index.dart';

class ChangeprofileRepository {
  final ChangeprofileProvider _changeprofileProvider = ChangeprofileProvider();
  final userRepo = UserRepository();

  ChangeprofileRepository();

  Future<User> getUser() async {
     await userRepo.updateUserData();
    return await userRepo.getCurrentUser();
  }

  Future<User> postServerUser(String token, Map<String, dynamic> bodyMap) async {
    return await _changeprofileProvider.requestChangeMode(token, bodyMap);
  }
}

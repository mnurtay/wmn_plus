import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/profile/changeprofile/index.dart';

class ChangeprofileRepository {
  final ChangeprofileProvider _changeprofileProvider = ChangeprofileProvider();
  final userRepo = UserRepository();

  ChangeprofileRepository();

  void test(bool isError) {
    this._changeprofileProvider.test(isError);
  }

  Future<User> getUser() async {
    return await userRepo.getCurrentUser();
  }
}

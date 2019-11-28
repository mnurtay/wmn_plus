import 'package:wmn_plus/features/profile/index.dart';

class ProfileRepository {
  final ProfileProvider _profileProvider = ProfileProvider();

  ProfileRepository();

  void test(bool isError) {
    this._profileProvider.test(isError);
  }
}
import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/fertility_duration/index.dart';

class FertilityDurationRepository {
  final FertilityDurationProvider _fertilityDurationProvider = FertilityDurationProvider();

  FertilityDurationRepository();

  void test(bool isError) {
    this._fertilityDurationProvider.test(isError);
  }
}
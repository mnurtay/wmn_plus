import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/fertility_period/index.dart';

class FertilityPeriodRepository {
  final FertilityPeriodProvider _fertilityPeriodProvider = FertilityPeriodProvider();

  FertilityPeriodRepository();

  void test(bool isError) {
    this._fertilityPeriodProvider.test(isError);
  }
}
import 'package:wmn_plus/features/discounts/index.dart';

class DiscountsRepository {
  final DiscountsProvider _discountsProvider = DiscountsProvider();

  DiscountsRepository();

  void test(bool isError) {
    this._discountsProvider.test(isError);
  }
}
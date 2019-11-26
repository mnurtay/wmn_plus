import 'package:wmn_plus/features/discounts/index.dart';

class DiscountsRepository {
  final DiscountsProvider _discountsProvider = DiscountsProvider();

  DiscountsRepository();

  Future<Discount> getDiscountsList(int category) async {
      var discounts = await _discountsProvider.fetchMoreDiscounts(category);
      return discounts;
  }
}
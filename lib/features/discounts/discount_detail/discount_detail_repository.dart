import 'package:wmn_plus/features/discounts/discount_detail/index.dart';

class DiscountDetailRepository {
  final DiscountDetailProvider _discountDetailProvider = DiscountDetailProvider();

  DiscountDetailRepository();

  void test(bool isError) {
    this._discountDetailProvider.test(isError);
  }
  Future<Discountdetail> fetchDiscountDetail(int cat, int id) {
    return _discountDetailProvider.getDiscountDetail(cat,id);
  }
}
import 'package:wmn_plus/features/shop/category_detail/index.dart';

class CategoryDetailRepository {
  final CategoryDetailProvider _categoryDetailProvider = CategoryDetailProvider();

  CategoryDetailRepository();

  void test(bool isError) {
    this._categoryDetailProvider.test(isError);
  }
}
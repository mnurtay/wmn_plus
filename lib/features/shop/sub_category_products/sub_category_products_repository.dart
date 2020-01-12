import 'package:wmn_plus/features/shop/sub_category_products/index.dart';

class SubCategoryProductsRepository {
  final SubCategoryProductsProvider _subCategoryProductsProvider =
      SubCategoryProductsProvider();

  SubCategoryProductsRepository();
  Future<ProductList> getSubCategoryPage(int sub, int id) async {
    // var userRepo = UserRepository();
    // String token = await userRepo.getToken();
    return await _subCategoryProductsProvider.getRequestProductList(sub, id);
  }
}

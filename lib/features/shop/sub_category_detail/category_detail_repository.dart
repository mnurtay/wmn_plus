import 'package:wmn_plus/features/shop/sub_category_detail/index.dart';

class CategoryDetailRepository {
  final CategoryDetailProvider _categoryDetailProvider = CategoryDetailProvider();

  CategoryDetailRepository();

  Future<SubCategoryList> getSubCategoryPage(int id) async {
    // var userRepo = UserRepository();
    // String token = await userRepo.getToken();
    return await _categoryDetailProvider.getRequestSubCategoryPage(id);
  }
}
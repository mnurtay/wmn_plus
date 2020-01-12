import 'package:wmn_plus/features/shop/product_detail/index.dart';

class ProductDetailRepository {
  final ProductDetailProvider _productDetailProvider = ProductDetailProvider();

  ProductDetailRepository();

  Future<ProductResponse> getProductDetails(int cat, int sub, int id) async {
    // var userRepo = UserRepository();
    // String token = await userRepo.getToken();
    return await _productDetailProvider.getRequestProductDetails(cat, sub, id);
  }
}

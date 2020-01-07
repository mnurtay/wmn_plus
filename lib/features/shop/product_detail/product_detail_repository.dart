import 'package:wmn_plus/features/shop/product_detail/index.dart';

class ProductDetailRepository {
  final ProductDetailProvider _productDetailProvider = ProductDetailProvider();

  ProductDetailRepository();

  void test(bool isError) {
    this._productDetailProvider.test(isError);
  }
}
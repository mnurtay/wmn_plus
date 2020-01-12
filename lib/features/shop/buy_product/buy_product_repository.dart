import 'package:wmn_plus/features/shop/buy_product/index.dart';

class BuyProductRepository {
  final BuyProductProvider _buyProductProvider = BuyProductProvider();

  BuyProductRepository();

  Future<ResponseJson> getProductDetails(BuyProduct product) async {
    // var userRepo = UserRepository();
    // String token = await userRepo.getToken();
    return await _buyProductProvider.postRequestBuyProduct(product);
  }
}

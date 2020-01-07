import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/shop/index.dart';

class ShopRepository {
  final ShopProvider _shopProvider = ShopProvider();

  ShopRepository();

  Future<Shop> getShopPage() async {
    var userRepo = UserRepository();
    String token = await userRepo.getToken();
    return await _shopProvider.getRequestShopPage(token);
  }
}

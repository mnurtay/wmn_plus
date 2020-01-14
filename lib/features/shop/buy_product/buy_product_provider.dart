import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/shop/buy_product/buy_product_model.dart'
    as BReponse;

class BuyProductProvider {
  Future<BReponse.ResponseJson> postRequestBuyProduct(
      BReponse.BuyProduct product) async {
    Response response;
    try {
      var userRepo = UserRepository();
      User user = await userRepo.getCurrentUser();
      response =
          await post('http://194.146.43.98:4000/api/v1/patient/buyproduct',
              headers: {
                "Content-Type": "application/json",
                "Authorization": "wmn538179 ${user.result.token}",
              },
              body: json.encode(product));
      String body = utf8.decode(response.bodyBytes);
      Map shopObj = json.decode(body);
      var shop = BReponse.ResponseJson.fromJson(shopObj);
      if (shop.statusCode == 200) {
        return shop;
      }
      throw (shop.message);
    } catch (error) {
      print(error);
      throw (error.toString());
    }
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/shop/sub_category_detail/category_detail_model.dart';
import 'package:wmn_plus/features/shop/sub_category_products/sub_category_products_model.dart';

class SubCategoryProductsProvider {
  Future<ProductList> getRequestProductList(int subId, int productId) async {
    Response response;
    try {
      response = await get(
          'http://194.146.43.98:4000/api/v1/patient/productslist/$subId/$productId',
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179 qwerty",
          });
      String body = utf8.decode(response.bodyBytes);
      Map shopObj = json.decode(body);
      var shop = ProductList.fromJson(shopObj);
      print(body);
      return shop;
    } catch (error) {
      print(error);
      throw (error.toString());
    }
  }
}

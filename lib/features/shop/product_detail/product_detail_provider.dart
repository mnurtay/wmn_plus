import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/shop/product_detail/index.dart';

class ProductDetailProvider {
  Future<ProductResponse> getRequestProductDetails(
      int cat, int sub, int id) async {
    Response response;
    try {
      response = await get(
          'http://194.146.43.98:4000/api/v1/patient/productdetail/$cat/$sub/$id',
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179 qwerty",
          });
      String body = utf8.decode(response.bodyBytes);
      Map shopObj = json.decode(body);
      var shop = ProductResponse.fromJson(shopObj);
      print(body);
      return shop;
    } catch (error) {
      print(error);
      throw (error.toString());
    }
  }
}

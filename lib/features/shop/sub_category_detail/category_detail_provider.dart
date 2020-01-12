import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/shop/sub_category_detail/category_detail_model.dart';

class CategoryDetailProvider {
  Future<SubCategoryList> getRequestSubCategoryPage(int id) async {
    Response response;
    try {
      response = await get(
          'http://194.146.43.98:4000/api/v1/patient/subcategorylist/$id',
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179 qwerty",
          });
      String body = utf8.decode(response.bodyBytes);
      Map shopObj = json.decode(body);
      var shop = SubCategoryList.fromJson(shopObj);
      print(body);
      return shop;
    } catch (error) {
      print(error);
      throw (error.toString());
    }
  }
}

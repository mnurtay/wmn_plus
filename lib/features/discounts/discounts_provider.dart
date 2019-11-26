import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/discounts/index.dart';

class DiscountsProvider {
  Future<Discount> fetchMoreDiscounts(int category) async {
    Response response;
    try {
      response = await get(
          'http://194.146.43.98:4000/api/v1/patient/sales/$category',
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179",
          });

      var discountsList = Discount.fromJson(json.decode(response.body));

      return discountsList;
    } catch (error) {
      throw (error.toString());
    }
  }
}

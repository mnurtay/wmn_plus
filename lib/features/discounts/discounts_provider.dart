import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/discounts/index.dart';

class DiscountsProvider {
  Future<Discount> fetchMoreDiscounts(int category) async {
    Response response;
    var userRepo = UserRepository();
    try {
      var user = await userRepo.getCurrentUser();
      response = await get(
          'http://194.146.43.98:4000/api/v1/patient/sales/$category',
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179 ${user.result.token}",
          });
      String body = utf8.decode(response.bodyBytes);
      Map disObject = json.decode(body);
      var discountsList = Discount.fromJson(disObject);
      print(response.body);
      return discountsList;
    } catch (error) {
      throw (error.toString());
    }
  }
}

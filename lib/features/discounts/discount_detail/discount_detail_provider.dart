import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/discounts/discount_detail/discount_detail_model.dart';

class DiscountDetailProvider {
  Future<void> loadAsync(String token) async {
    /// write from keystore/keychain
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> saveAsync(String token) async {
    /// write from keystore/keychain
    await Future.delayed(Duration(seconds: 2));
  }

  void test(bool isError) {
    if (isError == true){
      throw Exception("manual error");
    }
  }

  Future<Discountdetail> getDiscountDetail(String id) async {
    Response response;
    var userRepo = UserRepository();
    try {
      var user = await userRepo.getCurrentUser();
      response = await get('http://194.146.43.98:4000/api/v1/patient/saleDetail/$id',
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179 ${user.result.token}",
          });
      String body = utf8.decode(response.bodyBytes);
      Map disObject = json.decode(body);
      var discountDetails = Discountdetail.fromJson(disObject);
      print(body);
      return discountDetails;
    } catch (error) {
      print(error);
      throw (error.toString());
    }
  }
}


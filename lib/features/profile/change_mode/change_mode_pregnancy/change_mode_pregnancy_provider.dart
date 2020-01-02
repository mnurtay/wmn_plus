import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/model/User.dart' as Us;
import 'package:wmn_plus/features/registration/registration_model.dart';

class ChangeModePregnancyProvider {
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
      throw Exception('manual error');
    }
  }

  Future<Us.User> requestChangeMode(String token, Pregnancy pregnancy) async {
    Response response;
    print(pregnancy.toJson().toString());
    Map mp = {"pregnancy": pregnancy.toJson()};
    print(jsonEncode(mp));
    response = await post(
        'http://194.146.43.98:4000/api/v1/patient/changeRegime',
        body: json.encode(mp),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "wmn538179 $token",
        });
    // print(response.bodyBytes.toString());
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      Map regObject = json.decode(body);
      Us.User user = Us.User.fromJson(regObject);
      return user;
    } else {
      return null;
    }
  }
}


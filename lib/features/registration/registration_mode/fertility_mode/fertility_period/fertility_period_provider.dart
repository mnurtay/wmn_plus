import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

class FertilityPeriodProvider {
  Future<void> loadAsync(String token) async {
    /// write from keystore/keychain
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> saveAsync(String token) async {
    /// write from keystore/keychain
    await Future.delayed(Duration(seconds: 2));
  }

  Future<User> registerUser(RegistrationModel registrationModel) async {
    print(registrationModel.toJson().toString());
    Response response;
    try {
      response = await post('http://194.146.43.98:4000/api/v1/patient/registration',
          body: json.encode(registrationModel.toJson()),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179",
          });
      String body = utf8.decode(response.bodyBytes);
      Map regObject = json.decode(body);
      User user = User.fromJson(regObject);
      print(response.body.toString());
      return user;
    } catch (error) {
      print(error);
      throw (error.toString());
    }
  }
}


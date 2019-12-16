import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/registration/index.dart';

class PregnantModeProvider {
  Future<User> registerUser(RegistrationModel registrationModel) async {
    print(registrationModel.toJson().toString());
    Response response;
    try {
      response = await post(
          'http://194.146.43.98:4000/api/v1/patient/registration',
          body: json.encode(registrationModel.toJson()),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179",
          });
      String body = utf8.decode(response.bodyBytes);
      var user = User.fromJson(jsonDecode(body));
      print(body);
      return user;
    } catch (error) {
      print(error);
      throw (error.toString());
    }
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/registration/index.dart';

class PregnantModeProvider {
  Future<bool> registerUser(RegistrationModel registrationModel) async {
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
      var user = RegistrationModel.fromJson(regObject);
      print(response.body.toString());
      return true;
    } catch (error) {
      print(error);
      throw (error.toString());
    }
  }

}


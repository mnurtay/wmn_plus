import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/model/User.dart' as Us;
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/registration/index.dart';

class PregnantModeProvider {
  Future<Us.User> registerUser(RegistrationModel registrationModel) async {
    // print(registrationModel.toJson().toString());
    Response response;
    var token = await UserRepository().getToken();

    try {
      RegistrationModel model = new RegistrationModel(
        firstname: registrationModel.firstname,
        surname: registrationModel.surname,
        password: registrationModel.password,
        dateOfBirth: registrationModel.dateOfBirth,
        phone: registrationModel.phone,
        pushToken: token,
        pregnancy: Pregnancy(week: registrationModel.pregnancy.week),
      );

      response = await post(
          'http://194.146.43.98:4000/api/v1/patient/registration',
          body: json.encode(model.toJson()),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179",
          });
      String body = utf8.decode(response.bodyBytes);
      var user = Us.User.fromJson(jsonDecode(body));
      print(body);
      return user;
    } catch (error) {
      print(error);
      throw (error.toString());
    }
  }

  Future<Us.User> registerUserClimax(
      RegistrationModel registrationModel) async {
    Response response;
    var token = await UserRepository().getToken();

    try {
      RegistrationModel model = new RegistrationModel(
          firstname: registrationModel.firstname,
          surname: registrationModel.surname,
          password: registrationModel.password,
          dateOfBirth: registrationModel.dateOfBirth,
          phone: registrationModel.phone,
          pushToken: token,
          climax: "climax");

      response = await post(
          'http://194.146.43.98:4000/api/v1/patient/registration',
          body: json.encode(model.toJson()),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179",
          });
      String body = utf8.decode(response.bodyBytes);
      var user = Us.User.fromJson(jsonDecode(body));
      print(body);
      return user;
    } catch (error) {
      print(error);
      throw (error.toString());
    }
  }
}

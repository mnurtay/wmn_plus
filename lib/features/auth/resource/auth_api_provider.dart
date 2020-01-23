import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/util/config.dart';

class AuthApiProvider {
  Future<User> fetchAuthenticate(String username, String password) async {
    Response response;
    try {
      response = await post('http://194.146.43.98:4000/api/v1/patient/login',
          body: json.encode({"phone": username, "password": password}),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179",
          });
      String body = utf8.decode(response.bodyBytes);
      var user = User.fromJson(jsonDecode(body));
      return user;
    } catch (error) {
      throw (error.toString());
    }
  }

  Future<User> fetchAuthenticateDoctor(String username, String password) async {
    Response response;
    try {
      response = await post('http://194.146.43.98:4000/api/v1/doctor/login',
          body: json.encode({"login": username, "password": password}),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179",
          });
      String body = utf8.decode(response.bodyBytes);
      var user = User.fromJson(jsonDecode(body));
      return user;
    } catch (error) {
      throw (error.toString());
    }
  }

  Future<User> updateUserData(String token) async {
    User instance;
    Response response;
    try {
      response = await get(
        '$BACKEND_URL/api/v1/patient/me',
        headers: {"Authorization": "wmn538179 $token"},
      );
      String body = utf8.decode(response.bodyBytes);
      instance = User.fromJson(jsonDecode(body));
      if(instance.statusCode != 200)
        return User(result: Result(regime: "doctor"));
      else 
        return instance;
    } catch (e) {
      print(e);
      throw (e.toString());
    }
  }

  Future<void> fetchSignup({
    String fullName,
    String email,
    String number,
    String password,
  }) async {
    // await Future.delayed(Duration(seconds: 1));
  }
}

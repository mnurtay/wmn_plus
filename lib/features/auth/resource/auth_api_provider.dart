import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/model/User.dart';

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
      print(response.body.toString());
      return user;
    } catch (error) {
      print(error);
      throw (error.toString());
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

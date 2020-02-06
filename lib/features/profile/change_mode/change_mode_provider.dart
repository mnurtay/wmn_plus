import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/model/User.dart' as Us;
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

class ChangeModeProvider {
  Future<Us.User> requestChangeModeToClimax() async {
    try {
      User user = await UserRepository().getCurrentUser();

      Response response;
      Map mp = {"climax": "climax"};
      response = await post(
          'http://194.146.43.98:4000/api/v1/patient/changeRegime',
          body: json.encode(mp),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179 ${user.result.token}",
          });
      // print(response.bodyBytes.toString());
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        Map regObject = json.decode(body);
        Us.User user = Us.User.fromJson(regObject);
        print(regObject.toString());
        return user;
      } else {
        return null;
      }
    } catch (e) {
      throw (e);
    }
  }
}

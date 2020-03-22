import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/model/User.dart' as Us;

class ChangeprofileProvider {
  Future<Us.User> requestChangeMode(
      String token, Map<String, dynamic> bodyMap) async {
    Response response;
    print(bodyMap);
    response = await post('http://194.146.43.98:4000/api/v1/patient/changeInfo',
        body: json.encode(bodyMap),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "wmn538179 $token",
        });
    print(utf8.decode(response.bodyBytes));
    String body = utf8.decode(response.bodyBytes);
    Map regObject = json.decode(body);
    Us.User user = Us.User.fromJson(regObject);
    if (user.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      Map regObject = json.decode(body);
      Us.User user = Us.User.fromJson(regObject);
      return user;
    } else {
      return null;
    }
  }
}

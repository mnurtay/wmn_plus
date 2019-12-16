import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/profile/screen/language/index.dart';
import 'package:wmn_plus/features/profile/screen/language/language_event.dart';
import 'package:wmn_plus/util/config.dart';

class LanguageProvider {
  Future<void> loadAsync(String token) async {
    /// write from keystore/keychain
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> saveAsync(String token) async {
    /// write from keystore/keychain
    await Future.delayed(Duration(seconds: 2));
  }

  void test(bool isError) {
    if (isError == true) {
      throw Exception('manual error');
    }
  }

  Future<HttpStatus> changeLanguageRequest(LanguageType type) async {
    var userRepo = UserRepository();
    var languageType = "rus";
    if (type == LanguageType.English) {
      languageType = "eng";
    } else if (type == LanguageType.Russian) {
      languageType = "rus";
    } else {
      languageType = "kaz";
    }
    Response response;
    try {
      var user = await userRepo.getCurrentUser();
      response =
          await post('http://194.146.43.98:4000/api/v1/patient/changeLanguage',
              body: jsonEncode({
                'language': languageType,
              }),
              headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179 ${user.result.token}",
          });
      String body = utf8.decode(response.bodyBytes);
      print(body);
      if (response.statusCode == 200) {
        return HttpStatus.Success;
      }else {
        return HttpStatus.Error;
      }
    } catch (error) {
      print(error);
      throw (error.toString());
    }
  }
}

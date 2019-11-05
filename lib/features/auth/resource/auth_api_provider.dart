import 'dart:convert';
import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/model/User.dart';

class AuthApiProvider {
  Future<User> fetchAuthenticate(String username, String password) async {
    // await Future.delayed(Duration(seconds: 1));
    User user = User.anonymous();
    return user;
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

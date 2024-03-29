import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/auth/resource/auth_api_provider.dart';

class UserRepository {
  AuthApiProvider authProvider = AuthApiProvider();
  final String spKey = 'current_user';

  Future<User> authenticate({
    @required String username,
    @required String password,
  }) async {
    User user = await authProvider.fetchAuthenticate(username, password);
    return user;
  }

  Future<User> authenticateDoctor({
    @required String username,
    @required String password,
  }) async {
    User user = await authProvider.fetchAuthenticateDoctor(username, password);
    return user;
  }

  Future<void> signup({
    @required String fullName,
    @required String password,
    @required String email,
    @required String number,
  }) async {
    await authProvider.fetchSignup(
        fullName: fullName, number: number, email: email, password: password);
  }

  Future<bool> isAuthenticated() async {
    SharedPreferences spInstance = await SharedPreferences.getInstance();
    String jsonString = spInstance.getString(spKey);
    if (jsonString == null) {
      return false;
    }
    return true;
  }

  Future<User> getCurrentUser() async {
    SharedPreferences spInstance = await SharedPreferences.getInstance();
    String jsonString = spInstance.getString(spKey);
    if (jsonString != null) {
      return User.fromJson(json.decode(jsonString));
    }
    return User();
  }

  Future<void> setFirstLaunch() async {
    SharedPreferences spInstance = await SharedPreferences.getInstance();
    spInstance.setBool("isFirstLaunch", false);
  }

  Future<void> offFirstLaunch() async {
    SharedPreferences spInstance = await SharedPreferences.getInstance();
    spInstance.setBool("isFirstLaunch", false);
  }

  Future<void> persistToken(String token) async {
    SharedPreferences spInstance = await SharedPreferences.getInstance();
    spInstance.setString("anonymousPushToken", token);
  }

  Future<String> getToken() async {
    SharedPreferences spInstance = await SharedPreferences.getInstance();
    String token = spInstance.getString("anonymousPushToken");
    if (token != null) {
      return token;
    } else {
      return "";
    }
  }

  Future<User> updateUserData() async {
    User currentUser = await getCurrentUser();
    User updatedUser = await authProvider.updateUserData(
      currentUser.result.token,
    );
    if (updatedUser.result.regime == "doctor")
      return updatedUser;
    else {
      await persistUser(updatedUser);
      return updatedUser;
    }
  }

  Future<void> persistUser(User user) async {
    SharedPreferences spInstance = await SharedPreferences.getInstance();
    await spInstance.setString(spKey, jsonEncode(user));
  }

  Future<void> deleteUser() async {
    /// delete from keystore/keychain
    SharedPreferences spInstance = await SharedPreferences.getInstance();
    await spInstance.remove(spKey);
    // spInstance.remove(spKey);
    // spInstance.clear();
  }
}

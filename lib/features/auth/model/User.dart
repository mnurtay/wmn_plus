import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String token;

  User(
      {@required this.username,
      @required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.token});

  User.anonymous(
      {this.username = 'anonymous',
      this.firstName = 'anonymous',
      this.lastName = 'anonymoustoke',
      this.email = 'anonymous@gmail.com',
      this.token = 'qwerty'});

  factory User.parseJson(String jsonString) {
    Map objectMap = json.decode(jsonString);
    return User.parseMap(objectMap);
  }

  factory User.parseMap(Map objectMap) {
    User user = User(
        username: objectMap['user']['username'],
        firstName: objectMap['user']['first_name'],
        lastName: objectMap['user']['last_name'],
        email: objectMap['user']['email'],
        token: objectMap['token']);
    return user;
  }

  User getCopy() {
    User copy = User(
        username: this.username,
        firstName: this.firstName,
        lastName: this.lastName,
        email: this.email,
        token: this.token);
    return copy;
  }

  String objectToJsonString() {
    Map objectMap = {
      'username': this.username,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'email': this.email,
      'token': this.token
    };
    return json.encode(objectMap).toString();
  }

  static User jsonStringToObject(String jsonString) {
    Map objectMap = json.decode(jsonString);
    return User(
      username: objectMap['username'],
      firstName: objectMap['firstName'],
      lastName: objectMap['lastName'],
      email: objectMap['email'],
      token: objectMap['token'],
    );
  }

  String get getFullName => "${this.firstName} ${this.lastName}";
  String get getFirstName => "${this.firstName}";
  String get getLastName => "${this.lastName}";
  String get getEmail => "${this.email}";
  String get getToken => "wmn538179 ${this.token}";

  @override
  List<Object> get props => [username, firstName, lastName, email, token];
}

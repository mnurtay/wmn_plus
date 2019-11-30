import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Doctor extends Equatable {
  final int id;
  final String firstName;
  final String surname;
  final String secondName;
  final String image;
  final String token;
  final int positionId;
  final int experience;
  final String gender;
  final bool russianlanguage;
  final bool englishlanguage;
  final bool kazakhlanguage;
  final String study;
  final String speciality;
  final int price;

  Doctor(
      {@required this.id,
      @required this.firstName,
      @required this.surname,
      @required this.secondName,
      @required this.image,
      @required this.token,
      @required this.positionId,
      @required this.experience,
      @required this.gender,
      @required this.russianlanguage,
      @required this.englishlanguage,
      @required this.kazakhlanguage,
      @required this.study,
      @required this.speciality,
      @required this.price});

  Doctor.anonymous({
    this.id = 0,
    this.firstName = 'Gary',
    this.surname = 'Hawkins',
    this.secondName = '',
    this.image =
        'https://hcplive.s3.amazonaws.com/v1_media/_image/happydoctor.jpg',
    this.token = 'qaz',
    this.positionId = 0,
    this.experience = 100,
    this.gender = 'male',
    this.englishlanguage = true,
    this.russianlanguage = true,
    this.kazakhlanguage = true,
    this.study = '',
    this.speciality = '',
    this.price = 1239,
  });

  factory Doctor.parseObject(Map objectMap) {
    Doctor instance = Doctor(
        id: objectMap['id'],
        firstName: objectMap['firstname'],
        surname: objectMap['surname'],
        secondName: objectMap['secondname'],
        // image: objectMap['image'],
        image: 'https://hcplive.s3.amazonaws.com/v1_media/_image/happydoctor.jpg',
        token: objectMap['token'],
        positionId: objectMap['positionId'],
        experience: objectMap['experience'],
        gender: objectMap['gender'],
        englishlanguage: objectMap['englishlanguage'],
        russianlanguage: objectMap['russianlanguage'],
        kazakhlanguage: objectMap['kazakhlanguage'],
        study: objectMap['study'],
        speciality: objectMap['speciality'],
        price: objectMap['price']);
    return instance;
  }

  static List<Doctor> parseJsonToList(String jsonString) {
    List<Doctor> instance = [];
    Map objectList = json.decode(jsonString);
    objectList['result'].forEach((item) {
      instance.add(Doctor.parseObject(item));
    });
    return instance;
  }

  String get getToken => "wmn538179 ${this.token}";
  String get getFullName => "${this.firstName} ${this.surname} ${this.secondName}";

  @override
  List<Object> get props => null;
}

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
    this.token = 'Token ',
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

  @override
  List<Object> get props => null;
}

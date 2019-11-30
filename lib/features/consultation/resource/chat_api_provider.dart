import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wmn_plus/features/consultation/model/Doctor.dart';
import 'package:wmn_plus/util/config.dart';

class ChatApiProvider {
  Future<List<Doctor>> fetchDoctorsList({
    @required String token,
    @required int categoryId,
  }) async {
    List<Doctor> doctors = [];
    Response response;
    try {
      response = await get(
        '$BACKEND_URL/api/v1/patient/doctors/$categoryId',
        headers: {"Authorization": token},
      );
    } catch (e) {
      throw (e);
    }
    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ('пользователь не найден');
    } else if (response.statusCode >= 300) {
      throw ('повторите попытку позже возникла внутренняя проблема');
    } else if (response.statusCode >= 200 && response.statusCode < 300) {
      doctors = Doctor.parseJsonToList(utf8.decode(response.bodyBytes));
    }
    return doctors;
  }

  Future<Map> fetchConsultationPayment({@required String token, @required int doctorId}) async {
    Map payment = {};
    Response response;
    try {
      response = await get(
        '$BACKEND_URL/api/v1/patient/doctorPayment/$doctorId',
        headers: {"Authorization": token},
      );
    } catch (e) {
      throw (e);
    }
    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ('пользователь не найден');
    } else if (response.statusCode >= 300) {
      throw ('повторите попытку позже возникла внутренняя проблема');
    } else if (response.statusCode >= 200 && response.statusCode < 300) {
      payment = json.decode(utf8.decode(response.bodyBytes));
    }
    return payment;
  }
}

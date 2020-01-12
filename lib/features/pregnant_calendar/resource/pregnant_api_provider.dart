import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/pregnant_calendar/model/Pregnant.dart';
import 'package:wmn_plus/util/config.dart';

class PregnantApiProvider {
  Future<Pregnant> fetchPrognant(String token) async {
    Pregnant pregnant;
    Response response;
    try {
      response = await get(
        '$BACKEND_URL/api/v1/patient/calendar',
        headers: {"Authorization": "wmn538179 $token"},
      );
    } catch (e) {
      throw (e.toString());
    }
    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ('пользователь не найден');
    } else if (response.statusCode >= 300) {
      throw ('повторите попытку позже возникла внутренняя проблема');
    } else if (response.statusCode >= 200 && response.statusCode < 300) {
      pregnant = Pregnant.parseJson(utf8.decode(response.bodyBytes));
    }
    return pregnant;
  }
}

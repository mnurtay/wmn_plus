import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/fertility_calendar/fertility_calendar_model.dart';

class FertilityCalendarProvider {
  Future<FertilityCalendarModel> getRequestFertilityDays() async {
    Response response;
    var userRepo = UserRepository();
    try {
      var user = await userRepo.getCurrentUser();
      response = await get(
          'http://194.146.43.98:4000/api/v1/patient/calendar',
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179 ${user.result.token}",
          });
      String body = utf8.decode(response.bodyBytes);
      Map object = json.decode(body);
      FertilityCalendarModel fertilityCalendarModel =
          FertilityCalendarModel.fromJson(object);
      return fertilityCalendarModel;
    } catch (error) {
      throw (error.toString());
    }
  }
}

import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/fertility_calendar/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FertilityCalendarEvent {
  Future<FertilityCalendarState> applyAsync(
      {FertilityCalendarState currentState, FertilityCalendarBloc bloc});
  final FertilityCalendarRepository _fertilityCalendarRepository =
      FertilityCalendarRepository();
}

class UnFertilityCalendarEvent extends FertilityCalendarEvent {
  @override
  Future<FertilityCalendarState> applyAsync(
      {FertilityCalendarState currentState, FertilityCalendarBloc bloc}) async {
    return UnFertilityCalendarState(0);
  }
}

class LoadFertilityCalendarEvent extends FertilityCalendarEvent {
  final bool isError;
  @override
  String toString() => 'LoadFertilityCalendarEvent';

  LoadFertilityCalendarEvent(this.isError);

  @override
  Future<FertilityCalendarState> applyAsync(
      {FertilityCalendarState currentState, FertilityCalendarBloc bloc}) async {
    try {
      FertilityCalendarModel result =
          await this._fertilityCalendarRepository.getFertilityDays();
      var user = await UserRepository().getCurrentUser();

      List<DateTime> redDays = convertDaysToDate(result.result.redDays);
      List<DateTime> pmsDays = convertDaysToDate(result.result.pMS);
      List<DateTime> babyDays = convertDaysToDate(result.result.babyDays);
      var info = result.result.info;
      var newVal = Result(
          redDays: redDays, pMS: pmsDays, babyDays: babyDays, info: info);

      if (info.currentFert == 0) {
        if (info.toFert == 0) {
          if (!info.babyBoom) {
            if (info.toPMS == 0) {
              return ErrorFertilityCalendarState(
                  0, "Sorry, Try later".toString());
            } else {
              //topmsstate
              return InToPmsFertilityCalendarState(
                  0, newVal, user.result.getLanguage);
            }
          } else {
            //babyboom
            return InBabyFertilityCalendarState(
                0, newVal, user.result.getLanguage);
          }
        } else {
          //fert
          return InToFertFertilityCalendarState(
              0, newVal, user.result.getLanguage);
        }
      } else {
        return InFertilityCalendarState(0, newVal, user.result.getLanguage);
      }

    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadFertilityCalendarEvent', error: _, stackTrace: stackTrace);
      return ErrorFertilityCalendarState(0, _?.toString());
    }
  }

  List<DateTime> convertDaysToDate(List daysString) {
    List<DateTime> tempDays = [];
    for (int i = 0; i < daysString?.length; i++) {
      tempDays.add(DateTime.parse(daysString[i]));
    }
    return tempDays;
  }
}

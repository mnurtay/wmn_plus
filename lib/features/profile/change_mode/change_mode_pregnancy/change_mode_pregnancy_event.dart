import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/profile/change_mode/change_mode_pregnancy/index.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/registration/index.dart';

@immutable
abstract class ChangeModePregnancyEvent {
  Future<ChangeModePregnancyState> applyAsync(
      {ChangeModePregnancyState currentState, ChangeModePregnancyBloc bloc});
  final ChangeModePregnancyRepository _changeModePregnancyRepository =
      ChangeModePregnancyRepository();
}

class UnChangeModePregnancyEvent extends ChangeModePregnancyEvent {
  @override
  Future<ChangeModePregnancyState> applyAsync(
      {ChangeModePregnancyState currentState,
      ChangeModePregnancyBloc bloc}) async {
    return UnChangeModePregnancyState(0);
  }
}

class LoadChangeModePregnancyEvent extends ChangeModePregnancyEvent {
  final bool isError;
  @override
  String toString() => 'LoadChangeModePregnancyEvent';

  LoadChangeModePregnancyEvent(this.isError);

  @override
  Future<ChangeModePregnancyState> applyAsync(
      {ChangeModePregnancyState currentState,
      ChangeModePregnancyBloc bloc}) async {
    try {
      if (currentState is InChangeModePregnancyState) {
        return currentState.getNewVersion();
      }
      // await Future.delayed(Duration(seconds: 2));
      // this._changeModePregnancyRepository.test(this.isError);
      return InChangeModePregnancyState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadChangeModePregnancyEvent',
          error: _,
          stackTrace: stackTrace);
      return ErrorChangeModePregnancyState(0, _?.toString());
    }
  }
}

class CompleteChangeModePregnancyEvent extends ChangeModePregnancyEvent {
  Pregnancy pregnancy;

  @override
  String toString() => 'LoadChangeModeFertilityPeriodEvent';

  CompleteChangeModePregnancyEvent(this.pregnancy);

  @override
  Future<ChangeModePregnancyState> applyAsync(
      {ChangeModePregnancyState currentState,
      ChangeModePregnancyBloc bloc}) async {
    try {} catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadChangeModeFertilityPeriodEvent',
          error: _,
          stackTrace: stackTrace);
      return ErrorChangeModePregnancyState(0, _?.toString());
    }
  }
}

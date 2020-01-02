import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/change_mode_fertility_period/index.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

@immutable
abstract class ChangeModeFertilityPeriodEvent {
  Future<ChangeModeFertilityPeriodState> applyAsync(
      {ChangeModeFertilityPeriodState currentState, ChangeModeFertilityPeriodBloc bloc});
  final ChangeModeFertilityPeriodRepository _changeModeFertilityPeriodRepository = ChangeModeFertilityPeriodRepository();
}

class UnChangeModeFertilityPeriodEvent extends ChangeModeFertilityPeriodEvent {
  @override
  Future<ChangeModeFertilityPeriodState> applyAsync({ChangeModeFertilityPeriodState currentState, ChangeModeFertilityPeriodBloc bloc}) async {
    return UnChangeModeFertilityPeriodState(0);
  }
}

class CompleteChangeModeFertilityEvent extends ChangeModeFertilityPeriodEvent {
  Fertility fertility;
  @override
  String toString() => 'LoadChangeModeFertilityPeriodEvent';

  CompleteChangeModeFertilityEvent(this.fertility);

  @override
  Future<ChangeModeFertilityPeriodState> applyAsync(
      {ChangeModeFertilityPeriodState currentState, ChangeModeFertilityPeriodBloc bloc}) async {
    try {

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadChangeModeFertilityPeriodEvent', error: _, stackTrace: stackTrace);
      return ErrorChangeModeFertilityPeriodState(0, _?.toString());
    }
  }
}

class LoadChangeModeFertilityPeriodEvent extends ChangeModeFertilityPeriodEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadChangeModeFertilityPeriodEvent';

  LoadChangeModeFertilityPeriodEvent(this.isError);

  @override
  Future<ChangeModeFertilityPeriodState> applyAsync(
      {ChangeModeFertilityPeriodState currentState, ChangeModeFertilityPeriodBloc bloc}) async {
    try {
      if (currentState is InChangeModeFertilityPeriodState) {
        return currentState.getNewVersion();
      }
      
      return InChangeModeFertilityPeriodState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadChangeModeFertilityPeriodEvent', error: _, stackTrace: stackTrace);
      return ErrorChangeModeFertilityPeriodState(0, _?.toString());
    }
  }
}

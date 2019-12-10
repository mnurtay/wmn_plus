import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/registration/registration_mode/pregnant_mode/index.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

@immutable
abstract class PregnantModeEvent {
  Future<PregnantModeState> applyAsync(
      {PregnantModeState currentState, PregnantModeBloc bloc});
  final PregnantModeRepository _pregnantModeRepository = PregnantModeRepository();
}

class UnPregnantModeEvent extends PregnantModeEvent {
  @override
  Future<PregnantModeState> applyAsync({PregnantModeState currentState, PregnantModeBloc bloc}) async {
    return UnPregnantModeState(0);
  }
}

class LoadPregnantModeEvent extends PregnantModeEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadPregnantModeEvent';

  LoadPregnantModeEvent(this.isError);

  @override
  Future<PregnantModeState> applyAsync(
      {PregnantModeState currentState, PregnantModeBloc bloc}) async {
    try {
      if (currentState is InPregnantModeState) {
        return currentState.getNewVersion();
      }
     
      return InPregnantModeState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadPregnantModeEvent', error: _, stackTrace: stackTrace);
      return ErrorPregnantModeState(0, _?.toString());
    }
  }
}

class CompleteRegistrationEvent extends PregnantModeEvent {
  final RegistrationModel registrationModel;
  @override
  String toString() => 'LoadRegistrationEvent';

  CompleteRegistrationEvent(this.registrationModel);

  @override
  Future<PregnantModeState> applyAsync(
      {PregnantModeState currentState, PregnantModeBloc bloc}) async {
    try {

      return InPregnantModeState(0, "Hello world");
    } catch (_, stackTrace) {
      return ErrorPregnantModeState(0, _?.toString());
    }
  }
}


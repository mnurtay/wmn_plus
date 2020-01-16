import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/registration/registration_mode/index.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

@immutable
abstract class RegistrationModeEvent {
  Future<RegistrationModeState> applyAsync(
      {RegistrationModeState currentState, RegistrationModeBloc bloc});
}

class UnRegistrationModeEvent extends RegistrationModeEvent {
  @override
  Future<RegistrationModeState> applyAsync(
      {RegistrationModeState currentState, RegistrationModeBloc bloc}) async {
    return UnRegistrationModeState(0);
  }
}

class LoadRegistrationModeEvent extends RegistrationModeEvent {
  final bool isError;
  @override
  String toString() => 'LoadRegistrationModeEvent';

  LoadRegistrationModeEvent(this.isError);

  @override
  Future<RegistrationModeState> applyAsync(
      {RegistrationModeState currentState, RegistrationModeBloc bloc}) async {
    try {
      if (currentState is InRegistrationModeState) {
        return currentState.getNewVersion();
      }
      return InRegistrationModeState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadRegistrationModeEvent', error: _, stackTrace: stackTrace);
      return ErrorRegistrationModeState(0, _?.toString());
    }
  }
}

class CompleteRegistrationModeEvent extends RegistrationModeEvent {
    final RegistrationModel registrationModel;

  @override
  String toString() => 'LoadRegistrationModeEvent';

  CompleteRegistrationModeEvent(this.registrationModel);

  @override
  Future<RegistrationModeState> applyAsync(
      {RegistrationModeState currentState, RegistrationModeBloc bloc}) async {}
}

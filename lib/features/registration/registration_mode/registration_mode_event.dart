import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/registration/registration_mode/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegistrationModeEvent {
  Future<RegistrationModeState> applyAsync(
      {RegistrationModeState currentState, RegistrationModeBloc bloc});
  final RegistrationModeRepository _registrationModeRepository = RegistrationModeRepository();
}

class UnRegistrationModeEvent extends RegistrationModeEvent {
  @override
  Future<RegistrationModeState> applyAsync({RegistrationModeState currentState, RegistrationModeBloc bloc}) async {
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
      // await Future.delayed(Duration(seconds: 2));
      this._registrationModeRepository.test(this.isError);
      return InRegistrationModeState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadRegistrationModeEvent', error: _, stackTrace: stackTrace);
      return ErrorRegistrationModeState(0, _?.toString());
    }
  }
}

import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/registration/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegistrationEvent {
  Future<RegistrationState> applyAsync(
      {RegistrationState currentState, RegistrationBloc bloc});
  final RegistrationRepository _registrationRepository = RegistrationRepository();
}

class UnRegistrationEvent extends RegistrationEvent {
  @override
  Future<RegistrationState> applyAsync({RegistrationState currentState, RegistrationBloc bloc}) async {
    return UnRegistrationState(0);
  }
}

class LoadRegistrationEvent extends RegistrationEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadRegistrationEvent';

  LoadRegistrationEvent(this.isError);

  @override
  Future<RegistrationState> applyAsync(
      {RegistrationState currentState, RegistrationBloc bloc}) async {
    try {
      if (currentState is InRegistrationState) {
        return currentState.getNewVersion();
      }
      await Future.delayed(Duration(seconds: 2));
      this._registrationRepository.test(this.isError);
      return InRegistrationState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadRegistrationEvent', error: _, stackTrace: stackTrace);
      return ErrorRegistrationState(0, _?.toString());
    }
  }
}

import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/fertility_period/index.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

@immutable
abstract class FertilityPeriodEvent {
  Future<FertilityPeriodState> applyAsync(
      {FertilityPeriodState currentState, FertilityPeriodBloc bloc});
  final FertilityPeriodRepository _fertilityPeriodRepository =
      FertilityPeriodRepository();
}

class UnFertilityPeriodEvent extends FertilityPeriodEvent {
  @override
  Future<FertilityPeriodState> applyAsync(
      {FertilityPeriodState currentState, FertilityPeriodBloc bloc}) async {
    return UnFertilityPeriodState(0);
  }
}

class LoadFertilityPeriodEvent extends FertilityPeriodEvent {
  final bool isError;
  @override
  String toString() => 'LoadFertilityPeriodEvent';

  LoadFertilityPeriodEvent(this.isError);

  @override
  Future<FertilityPeriodState> applyAsync(
      {FertilityPeriodState currentState, FertilityPeriodBloc bloc}) async {
    try {
      if (currentState is InFertilityPeriodState) {
        return currentState.getNewVersion();
      }

      // this._fertilityPeriodRepository.test(this.isError);
      return InFertilityPeriodState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadFertilityPeriodEvent', error: _, stackTrace: stackTrace);
      return ErrorFertilityPeriodState(0, _?.toString());
    }
  }
  //
}

class UserFertilityModeRegisterEvent extends FertilityPeriodEvent {
  final RegistrationModel user;
  @override
  String toString() => 'LoadFertilityPeriodEvent';

  UserFertilityModeRegisterEvent(this.user);

  @override
  Future<FertilityPeriodState> applyAsync(
      {FertilityPeriodState currentState, FertilityPeriodBloc bloc}) async {
    try {
      if (currentState is InFertilityPeriodState) {
        return currentState.getNewVersion();
      }
      // provider
      await Future.delayed(Duration(seconds: 3));

      return OutFertilityPeriodState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadFertilityPeriodEvent', error: _, stackTrace: stackTrace);
      return ErrorFertilityPeriodState(0, _?.toString());
    }
  }
}

class CompleteRegistrationEvent extends FertilityPeriodEvent {
  final RegistrationModel registrationModel;

  @override
  String toString() => 'LoadRegistrationEvent';

  CompleteRegistrationEvent(this.registrationModel);

  @override
  Future<FertilityPeriodState> applyAsync(
      {FertilityPeriodState currentState, FertilityPeriodBloc bloc}) async {
    try {
      return InFertilityPeriodState(0, "Hello world");
    } catch (_, stackTrace) {
      return ErrorFertilityPeriodState(0, _?.toString());
    }
  }
}

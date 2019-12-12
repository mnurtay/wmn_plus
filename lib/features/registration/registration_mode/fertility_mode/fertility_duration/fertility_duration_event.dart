import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/fertility_duration/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FertilityDurationEvent {
  Future<FertilityDurationState> applyAsync(
      {FertilityDurationState currentState, FertilityDurationBloc bloc});
  final FertilityDurationRepository _fertilityDurationRepository = FertilityDurationRepository();
}

class UnFertilityDurationEvent extends FertilityDurationEvent {
  @override
  Future<FertilityDurationState> applyAsync({FertilityDurationState currentState, FertilityDurationBloc bloc}) async {
    return UnFertilityDurationState(0);
  }
}

class LoadFertilityDurationEvent extends FertilityDurationEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadFertilityDurationEvent';

  LoadFertilityDurationEvent(this.isError);

  @override
  Future<FertilityDurationState> applyAsync(
      {FertilityDurationState currentState, FertilityDurationBloc bloc}) async {
    try {
      if (currentState is InFertilityDurationState) {
        return currentState.getNewVersion();
      }
      // await Future.delayed(Duration(seconds: 2));
      this._fertilityDurationRepository.test(this.isError);
      return InFertilityDurationState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadFertilityDurationEvent', error: _, stackTrace: stackTrace);
      return ErrorFertilityDurationState(0, _?.toString());
    }
  }
}

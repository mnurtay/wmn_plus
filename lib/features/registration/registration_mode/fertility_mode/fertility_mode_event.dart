import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FertilityModeEvent {
  Future<FertilityModeState> applyAsync(
      {FertilityModeState currentState, FertilityModeBloc bloc});
}

class UnFertilityModeEvent extends FertilityModeEvent {
  @override
  Future<FertilityModeState> applyAsync({FertilityModeState currentState, FertilityModeBloc bloc}) async {
    return UnFertilityModeState(0);
  }
}

class LoadFertilityModeEvent extends FertilityModeEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadFertilityModeEvent';

  LoadFertilityModeEvent(this.isError);

  @override
  Future<FertilityModeState> applyAsync(
      {FertilityModeState currentState, FertilityModeBloc bloc}) async {
    try {
      if (currentState is InFertilityModeState) {
        return currentState.getNewVersion();
      }

      return InFertilityModeState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadFertilityModeEvent', error: _, stackTrace: stackTrace);
      return ErrorFertilityModeState(0, _?.toString());
    }
  }
}

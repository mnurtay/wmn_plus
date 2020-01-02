import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/change_mode_fertility_duration/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChangeModeFertilityDurationEvent {
  Future<ChangeModeFertilityDurationState> applyAsync(
      {ChangeModeFertilityDurationState currentState, ChangeModeFertilityDurationBloc bloc});
  final ChangeModeFertilityDurationRepository _changeModeFertilityDurationRepository = ChangeModeFertilityDurationRepository();
}

class UnChangeModeFertilityDurationEvent extends ChangeModeFertilityDurationEvent {
  @override
  Future<ChangeModeFertilityDurationState> applyAsync({ChangeModeFertilityDurationState currentState, ChangeModeFertilityDurationBloc bloc}) async {
    return UnChangeModeFertilityDurationState(0);
  }
}

class LoadChangeModeFertilityDurationEvent extends ChangeModeFertilityDurationEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadChangeModeFertilityDurationEvent';

  LoadChangeModeFertilityDurationEvent(this.isError);

  @override
  Future<ChangeModeFertilityDurationState> applyAsync(
      {ChangeModeFertilityDurationState currentState, ChangeModeFertilityDurationBloc bloc}) async {
    try {
      if (currentState is InChangeModeFertilityDurationState) {
        return currentState.getNewVersion();
      }
      
      return InChangeModeFertilityDurationState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadChangeModeFertilityDurationEvent', error: _, stackTrace: stackTrace);
      return ErrorChangeModeFertilityDurationState(0, _?.toString());
    }
  }
}

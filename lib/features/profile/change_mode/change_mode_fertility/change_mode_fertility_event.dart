import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChangeModeFertilityEvent {
  Future<ChangeModeFertilityState> applyAsync(
      {ChangeModeFertilityState currentState, ChangeModeFertilityBloc bloc});
  final ChangeModeFertilityRepository _changeModeFertilityRepository = ChangeModeFertilityRepository();
}

class UnChangeModeFertilityEvent extends ChangeModeFertilityEvent {
  @override
  Future<ChangeModeFertilityState> applyAsync({ChangeModeFertilityState currentState, ChangeModeFertilityBloc bloc}) async {
    return UnChangeModeFertilityState(0);
  }
}

class LoadChangeModeFertilityEvent extends ChangeModeFertilityEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadChangeModeFertilityEvent';

  LoadChangeModeFertilityEvent(this.isError);

  @override
  Future<ChangeModeFertilityState> applyAsync(
      {ChangeModeFertilityState currentState, ChangeModeFertilityBloc bloc}) async {
    try {
      if (currentState is InChangeModeFertilityState) {
        return currentState.getNewVersion();
      }
    
      return InChangeModeFertilityState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadChangeModeFertilityEvent', error: _, stackTrace: stackTrace);
      return ErrorChangeModeFertilityState(0, _?.toString());
    }
  }
}

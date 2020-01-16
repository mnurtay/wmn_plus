import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/profile/change_mode/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChangeModeEvent {
  Future<ChangeModeState> applyAsync(
      {ChangeModeState currentState, ChangeModeBloc bloc});
  final ChangeModeRepository _changeModeRepository = ChangeModeRepository();
}

class UnChangeModeEvent extends ChangeModeEvent {
  @override
  Future<ChangeModeState> applyAsync(
      {ChangeModeState currentState, ChangeModeBloc bloc}) async {
    return UnChangeModeState(0);
  }
}

class LoadChangeModeEvent extends ChangeModeEvent {
  final bool isError;
  @override
  String toString() => 'LoadChangeModeEvent';

  LoadChangeModeEvent(this.isError);

  @override
  Future<ChangeModeState> applyAsync(
      {ChangeModeState currentState, ChangeModeBloc bloc}) async {
    try {
      if (currentState is InChangeModeState) {
        return currentState.getNewVersion();
      }

      return InChangeModeState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadChangeModeEvent', error: _, stackTrace: stackTrace);
      return ErrorChangeModeState(0, _?.toString());
    }
  }
}

class CompleteChangeModeEvent extends ChangeModeEvent {
  @override
  String toString() => 'LoadChangeModeEvent';

  CompleteChangeModeEvent();

  @override
  Future<ChangeModeState> applyAsync(
      {ChangeModeState currentState, ChangeModeBloc bloc}) async {
             return InChangeModeState(0, "Hello world");
      }
}

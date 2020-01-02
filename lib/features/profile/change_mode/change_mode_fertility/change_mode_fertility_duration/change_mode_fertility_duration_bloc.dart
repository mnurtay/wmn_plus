import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/change_mode_fertility_duration/index.dart';

class ChangeModeFertilityDurationBloc extends Bloc<ChangeModeFertilityDurationEvent, ChangeModeFertilityDurationState> {
  // todo: check singleton for logic in project
  static final ChangeModeFertilityDurationBloc _changeModeFertilityDurationBlocSingleton = ChangeModeFertilityDurationBloc._internal();
  factory ChangeModeFertilityDurationBloc() {
    return _changeModeFertilityDurationBlocSingleton;
  }
  ChangeModeFertilityDurationBloc._internal();
  
  @override
  Future<void> close() async{
    // dispose objects
    super.close();
  }

  ChangeModeFertilityDurationState get initialState => UnChangeModeFertilityDurationState(0);

  @override
  Stream<ChangeModeFertilityDurationState> mapEventToState(
    ChangeModeFertilityDurationEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ChangeModeFertilityDurationBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}

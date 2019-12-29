import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/index.dart';

class ChangeModeFertilityBloc extends Bloc<ChangeModeFertilityEvent, ChangeModeFertilityState> {
  // todo: check singleton for logic in project
  static final ChangeModeFertilityBloc _changeModeFertilityBlocSingleton = ChangeModeFertilityBloc._internal();
  factory ChangeModeFertilityBloc() {
    return _changeModeFertilityBlocSingleton;
  }
  ChangeModeFertilityBloc._internal();
  
  @override
  Future<void> close() async{
    // dispose objects
    super.close();
  }

  ChangeModeFertilityState get initialState => UnChangeModeFertilityState(0);

  @override
  Stream<ChangeModeFertilityState> mapEventToState(
    ChangeModeFertilityEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ChangeModeFertilityBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}

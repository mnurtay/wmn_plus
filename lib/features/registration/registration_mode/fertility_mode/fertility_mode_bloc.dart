import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/index.dart';

class FertilityModeBloc extends Bloc<FertilityModeEvent, FertilityModeState> {
  // todo: check singleton for logic in project
  static final FertilityModeBloc _fertilityModeBlocSingleton = FertilityModeBloc._internal();
  factory FertilityModeBloc() {
    return _fertilityModeBlocSingleton;
  }
  FertilityModeBloc._internal();
  
  @override
  Future<void> close() async{
    // dispose objects
    super.close();
  }

  FertilityModeState get initialState => UnFertilityModeState(0);

  @override
  Stream<FertilityModeState> mapEventToState(
    FertilityModeEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'FertilityModeBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PregnantBloc extends Bloc<PregnantEvent, PregnantState> {
  @override
  PregnantState get initialState => InitialPregnantState();

  @override
  Stream<PregnantState> mapEventToState(
    PregnantEvent event,
  ) async* {
    if (event is SelectDatePregnantEvent) {
      yield LoadingPregnantState();
      yield SelectedDatePregnantState(event.dateTime);
    }
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/pregnant_calendar/resource/pregnant_repository.dart';
import './bloc.dart';

class PregnantBloc extends Bloc<PregnantEvent, PregnantState> {
  PregnantRepository pregnantRepository = PregnantRepository();

  @override
  PregnantState get initialState => InitialPregnantState();

  @override
  Stream<PregnantState> mapEventToState(
    PregnantEvent event,
  ) async* {
    if (event is InitialPregnantEvent) {
      yield InitialPregnantState();
    }
    // When select date from main calendar
    if (event is SelectDatePregnantEvent) {
      yield LoadingPregnantState();
      final pregnant = await pregnantRepository.getPregnantData();
      yield SelectedDatePregnantState(
          dateTime: event.dateTime, pregnant: pregnant);
    }
    if (event is TodaysPregnantEvent) {
      final pregnant = await pregnantRepository.getPregnantData();
      yield TodaysPregnantState(pregnant: pregnant);
    }
    if (event is FetchPregnantEvent) {
      yield LoadingPregnantState();
      try {
        final pregnant = await pregnantRepository.fetchPregnant();
        yield TodaysPregnantState(pregnant: pregnant);
      } catch (e) {
        yield FailurePregnantState(e.toString());
      }
    }
  }
}

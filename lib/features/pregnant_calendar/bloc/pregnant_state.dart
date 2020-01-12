import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/pregnant_calendar/model/Pregnant.dart';

@immutable
abstract class PregnantState extends Equatable {}

class InitialPregnantState extends PregnantState {
  @override
  List<Object> get props => null;
}

class FailurePregnantState extends PregnantState {
  final String error;
  FailurePregnantState(this.error);
  @override
  List<Object> get props => null;
}

class LoadingPregnantState extends PregnantState {
  @override
  List<Object> get props => null;
}

class SelectedDatePregnantState extends PregnantState {
  final DateTime dateTime;
  final Pregnant pregnant;
  SelectedDatePregnantState({
    @required this.dateTime,
    @required this.pregnant,
  });
  @override
  List<Object> get props => null;
}

class TodaysPregnantState extends PregnantState {
  final Pregnant pregnant;

  TodaysPregnantState({@required this.pregnant});
  @override
  List<Object> get props => null;
}

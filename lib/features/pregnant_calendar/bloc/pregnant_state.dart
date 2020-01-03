import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PregnantState extends Equatable {}

class InitialPregnantState extends PregnantState {
  @override
  List<Object> get props => null;
}

class LoadingPregnantState extends PregnantState {
  @override
  List<Object> get props => null;
}

class SelectedDatePregnantState extends PregnantState {
  final DateTime dateTime;

  SelectedDatePregnantState(this.dateTime);
  @override
  List<Object> get props => null;
}

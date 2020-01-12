import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PregnantEvent extends Equatable {}

class InitialPregnantEvent extends PregnantEvent {
  @override
  List<Object> get props => null;
}

class SelectDatePregnantEvent extends PregnantEvent {
  final DateTime dateTime;

  SelectDatePregnantEvent(this.dateTime);
  @override
  List<Object> get props => null;
}

class TodaysPregnantEvent extends PregnantEvent {
  @override
  List<Object> get props => null;
}

class FetchPregnantEvent extends PregnantEvent {
  @override
  List<Object> get props => null;
}

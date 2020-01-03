import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PregnantEvent extends Equatable {}

class SelectDatePregnantEvent extends PregnantEvent {
  final DateTime dateTime;

  SelectDatePregnantEvent(this.dateTime);
  @override
  List<Object> get props => null;
}

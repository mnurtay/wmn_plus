import 'package:equatable/equatable.dart';

abstract class PregnantModeState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  PregnantModeState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  PregnantModeState getStateCopy();

  PregnantModeState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnPregnantModeState extends PregnantModeState {

  UnPregnantModeState(int version) : super(version);

  @override
  String toString() => 'UnPregnantModeState';

  @override
  UnPregnantModeState getStateCopy() {
    return UnPregnantModeState(0);
  }

  @override
  UnPregnantModeState getNewVersion() {
    return UnPregnantModeState(version+1);
  }
}

/// Initialized
class InPregnantModeState extends PregnantModeState {
  final String hello;

  InPregnantModeState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InPregnantModeState $hello';

  @override
  InPregnantModeState getStateCopy() {
    return InPregnantModeState(this.version, this.hello);
  }

  @override
  InPregnantModeState getNewVersion() {
    return InPregnantModeState(version+1, this.hello);
  }
}

class ErrorPregnantModeState extends PregnantModeState {
  final String errorMessage;

  ErrorPregnantModeState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorPregnantModeState';

  @override
  ErrorPregnantModeState getStateCopy() {
    return ErrorPregnantModeState(this.version, this.errorMessage);
  }

  @override
  ErrorPregnantModeState getNewVersion() {
    return ErrorPregnantModeState(version+1, this.errorMessage);
  }
}

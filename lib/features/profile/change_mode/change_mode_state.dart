import 'package:equatable/equatable.dart';

abstract class ChangeModeState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  ChangeModeState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ChangeModeState getStateCopy();

  ChangeModeState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnChangeModeState extends ChangeModeState {

  UnChangeModeState(int version) : super(version);

  @override
  String toString() => 'UnChangeModeState';

  @override
  UnChangeModeState getStateCopy() {
    return UnChangeModeState(0);
  }

  @override
  UnChangeModeState getNewVersion() {
    return UnChangeModeState(version+1);
  }
}

/// Initialized
class InChangeModeState extends ChangeModeState {
  final String hello;

  InChangeModeState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InChangeModeState $hello';

  @override
  InChangeModeState getStateCopy() {
    return InChangeModeState(this.version, this.hello);
  }

  @override
  InChangeModeState getNewVersion() {
    return InChangeModeState(version+1, this.hello);
  }
}

class ErrorChangeModeState extends ChangeModeState {
  final String errorMessage;

  ErrorChangeModeState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorChangeModeState';

  @override
  ErrorChangeModeState getStateCopy() {
    return ErrorChangeModeState(this.version, this.errorMessage);
  }

  @override
  ErrorChangeModeState getNewVersion() {
    return ErrorChangeModeState(version+1, this.errorMessage);
  }
}

import 'package:equatable/equatable.dart';

abstract class RegistrationModeState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  RegistrationModeState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  RegistrationModeState getStateCopy();

  RegistrationModeState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnRegistrationModeState extends RegistrationModeState {

  UnRegistrationModeState(int version) : super(version);

  @override
  String toString() => 'UnRegistrationModeState';

  @override
  UnRegistrationModeState getStateCopy() {
    return UnRegistrationModeState(0);
  }

  @override
  UnRegistrationModeState getNewVersion() {
    return UnRegistrationModeState(version+1);
  }
}

/// Initialized
class InRegistrationModeState extends RegistrationModeState {
  final String hello;

  InRegistrationModeState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InRegistrationModeState $hello';

  @override
  InRegistrationModeState getStateCopy() {
    return InRegistrationModeState(this.version, this.hello);
  }

  @override
  InRegistrationModeState getNewVersion() {
    return InRegistrationModeState(version+1, this.hello);
  }
}

class ErrorRegistrationModeState extends RegistrationModeState {
  final String errorMessage;

  ErrorRegistrationModeState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorRegistrationModeState';

  @override
  ErrorRegistrationModeState getStateCopy() {
    return ErrorRegistrationModeState(this.version, this.errorMessage);
  }

  @override
  ErrorRegistrationModeState getNewVersion() {
    return ErrorRegistrationModeState(version+1, this.errorMessage);
  }
}

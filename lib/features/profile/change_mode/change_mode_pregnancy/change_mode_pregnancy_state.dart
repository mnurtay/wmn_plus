import 'package:equatable/equatable.dart';
import 'package:wmn_plus/features/auth/model/User.dart';

abstract class ChangeModePregnancyState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  ChangeModePregnancyState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ChangeModePregnancyState getStateCopy();

  ChangeModePregnancyState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnChangeModePregnancyState extends ChangeModePregnancyState {

  UnChangeModePregnancyState(int version) : super(version);

  @override
  String toString() => 'UnChangeModePregnancyState';

  @override
  UnChangeModePregnancyState getStateCopy() {
    return UnChangeModePregnancyState(0);
  }

  @override
  UnChangeModePregnancyState getNewVersion() {
    return UnChangeModePregnancyState(version+1);
  }
}

/// Initialized
class InChangeModePregnancyState extends ChangeModePregnancyState {
  final String hello;

  InChangeModePregnancyState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InChangeModePregnancyState $hello';

  @override
  InChangeModePregnancyState getStateCopy() {
    return InChangeModePregnancyState(this.version, this.hello);
  }

  @override
  InChangeModePregnancyState getNewVersion() {
    return InChangeModePregnancyState(version+1, this.hello);
  }
}

class ErrorChangeModePregnancyState extends ChangeModePregnancyState {
  final String errorMessage;

  ErrorChangeModePregnancyState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorChangeModePregnancyState';

  @override
  ErrorChangeModePregnancyState getStateCopy() {
    return ErrorChangeModePregnancyState(this.version, this.errorMessage);
  }

  @override
  ErrorChangeModePregnancyState getNewVersion() {
    return ErrorChangeModePregnancyState(version+1, this.errorMessage);
  }
}

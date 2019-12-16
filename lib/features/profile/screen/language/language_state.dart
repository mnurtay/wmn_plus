import 'package:equatable/equatable.dart';

abstract class LanguageState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  LanguageState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  LanguageState getStateCopy();

  LanguageState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnLanguageState extends LanguageState {

  UnLanguageState(int version) : super(version);

  @override
  String toString() => 'UnLanguageState';

  @override
  UnLanguageState getStateCopy() {
    return UnLanguageState(0);
  }

  @override
  UnLanguageState getNewVersion() {
    return UnLanguageState(version+1);
  }
}

/// Initialized
class InLanguageState extends LanguageState {
  final String hello;

  InLanguageState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InLanguageState $hello';

  @override
  InLanguageState getStateCopy() {
    return InLanguageState(this.version, this.hello);
  }

  @override
  InLanguageState getNewVersion() {
    return InLanguageState(version+1, this.hello);
  }
}

class ErrorLanguageState extends LanguageState {
  final String errorMessage;

  ErrorLanguageState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorLanguageState';

  @override
  ErrorLanguageState getStateCopy() {
    return ErrorLanguageState(this.version, this.errorMessage);
  }

  @override
  ErrorLanguageState getNewVersion() {
    return ErrorLanguageState(version+1, this.errorMessage);
  }
}

import 'package:equatable/equatable.dart';

abstract class CategoryDetailState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  CategoryDetailState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  CategoryDetailState getStateCopy();

  CategoryDetailState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnCategoryDetailState extends CategoryDetailState {

  UnCategoryDetailState(int version) : super(version);

  @override
  String toString() => 'UnCategoryDetailState';

  @override
  UnCategoryDetailState getStateCopy() {
    return UnCategoryDetailState(0);
  }

  @override
  UnCategoryDetailState getNewVersion() {
    return UnCategoryDetailState(version+1);
  }
}

/// Initialized
class InCategoryDetailState extends CategoryDetailState {
  final String hello;

  InCategoryDetailState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InCategoryDetailState $hello';

  @override
  InCategoryDetailState getStateCopy() {
    return InCategoryDetailState(this.version, this.hello);
  }

  @override
  InCategoryDetailState getNewVersion() {
    return InCategoryDetailState(version+1, this.hello);
  }
}

class ErrorCategoryDetailState extends CategoryDetailState {
  final String errorMessage;

  ErrorCategoryDetailState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorCategoryDetailState';

  @override
  ErrorCategoryDetailState getStateCopy() {
    return ErrorCategoryDetailState(this.version, this.errorMessage);
  }

  @override
  ErrorCategoryDetailState getNewVersion() {
    return ErrorCategoryDetailState(version+1, this.errorMessage);
  }
}

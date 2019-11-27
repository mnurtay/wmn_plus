import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/discounts/index.dart';

@immutable
abstract class DiscountsState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final Iterable propss;
  DiscountsState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  DiscountsState getStateCopy();

  DiscountsState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnDiscountsState extends DiscountsState {

  UnDiscountsState(version) : super(version);

  @override
  String toString() => 'UnDiscountsState';

  @override
  UnDiscountsState getStateCopy() {
    return UnDiscountsState(0);
  }

  @override
  UnDiscountsState getNewVersion() {
    return UnDiscountsState(version+1);
  }
}

/// Initialized
class InDiscountsState extends DiscountsState {
  final Discount discount;

  InDiscountsState(version, this.discount) : super(version, [discount]);

  @override
  String toString() => 'InDiscountsState';

  @override
  InDiscountsState getStateCopy() {
    return InDiscountsState(this.version, this.discount);
  }

  @override
  InDiscountsState getNewVersion() {
    return InDiscountsState(version+1, this.discount);
  }
}

class ErrorDiscountsState extends DiscountsState {
  final String errorMessage;

  ErrorDiscountsState(version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorDiscountsState';

  @override
  ErrorDiscountsState getStateCopy() {
    return ErrorDiscountsState(this.version, this.errorMessage);
  }

  @override
  ErrorDiscountsState getNewVersion() {
    return ErrorDiscountsState(version+1, this.errorMessage);
  }
}

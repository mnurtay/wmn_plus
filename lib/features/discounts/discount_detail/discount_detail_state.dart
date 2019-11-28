import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/discounts/discount_detail/discount_detail_model.dart';

abstract class DiscountDetailState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final Iterable propss;
  DiscountDetailState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  DiscountDetailState getStateCopy();

  DiscountDetailState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnDiscountDetailState extends DiscountDetailState {

  UnDiscountDetailState(version) : super(version);

  @override
  String toString() => 'UnDiscountDetailState';

  @override
  UnDiscountDetailState getStateCopy() {
    return UnDiscountDetailState(0);
  }

  @override
  UnDiscountDetailState getNewVersion() {
    return UnDiscountDetailState(version+1);
  }
}

/// Initialized
class InDiscountDetailState extends DiscountDetailState {
  final Discountdetail hello;

  InDiscountDetailState(version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InDiscountDetailState $hello';

  @override
  InDiscountDetailState getStateCopy() {
    return InDiscountDetailState(this.version, this.hello);
  }

  @override
  InDiscountDetailState getNewVersion() {
    return InDiscountDetailState(version+1, this.hello);
  }
}

class ErrorDiscountDetailState extends DiscountDetailState {
  final String errorMessage;

  ErrorDiscountDetailState(version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorDiscountDetailState';

  @override
  ErrorDiscountDetailState getStateCopy() {
    return ErrorDiscountDetailState(this.version, this.errorMessage);
  }

  @override
  ErrorDiscountDetailState getNewVersion() {
    return ErrorDiscountDetailState(version+1, this.errorMessage);
  }
}

import 'package:equatable/equatable.dart';
import 'package:wmn_plus/features/shop/buy_product/buy_product_model.dart';

abstract class BuyProductState extends Equatable {
  /// notify change state without deep clone state
  final int version;

  final List propss;
  BuyProductState(this.version, [this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  BuyProductState getStateCopy();

  BuyProductState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnBuyProductState extends BuyProductState {
  UnBuyProductState(int version) : super(version);

  @override
  String toString() => 'UnBuyProductState';

  @override
  UnBuyProductState getStateCopy() {
    return UnBuyProductState(0);
  }

  @override
  UnBuyProductState getNewVersion() {
    return UnBuyProductState(version + 1);
  }
}

/// Initialized
class InBuyProductState extends BuyProductState {
  final String hello;

  InBuyProductState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InBuyProductState $hello';

  @override
  InBuyProductState getStateCopy() {
    return InBuyProductState(this.version, this.hello);
  }

  @override
  InBuyProductState getNewVersion() {
    return InBuyProductState(version + 1, this.hello);
  }
}

class ErrorBuyProductState extends BuyProductState {
  final String errorMessage;

  ErrorBuyProductState(int version, this.errorMessage)
      : super(version, [errorMessage]);

  @override
  String toString() => 'ErrorBuyProductState';

  @override
  ErrorBuyProductState getStateCopy() {
    return ErrorBuyProductState(this.version, this.errorMessage);
  }

  @override
  ErrorBuyProductState getNewVersion() {
    return ErrorBuyProductState(version + 1, this.errorMessage);
  }
}

class CompleteBuyProductState extends BuyProductState {
  final BuyProduct product;
  CompleteBuyProductState(this.product) : super(0, [product]);
  @override
  String toString() => 'ErrorBuyProductState';

  @override
  CompleteBuyProductState getStateCopy() {
    return CompleteBuyProductState(this.product);
  }

  @override
  CompleteBuyProductState getNewVersion() {
    return CompleteBuyProductState(this.product);
  }
}

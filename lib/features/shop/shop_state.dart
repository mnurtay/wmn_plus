import 'package:equatable/equatable.dart';
import 'package:wmn_plus/features/shop/shop_model.dart';

abstract class ShopState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  ShopState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ShopState getStateCopy();

  ShopState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnShopState extends ShopState {

  UnShopState(int version) : super(version);

  @override
  String toString() => 'UnShopState';

  @override
  UnShopState getStateCopy() {
    return UnShopState(0);
  }

  @override
  UnShopState getNewVersion() {
    return UnShopState(version+1);
  }
}

/// Initialized
class InShopState extends ShopState {
  final CategoryList hello;

  InShopState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InShopState $hello';

  @override
  InShopState getStateCopy() {
    return InShopState(this.version, this.hello);
  }

  @override
  InShopState getNewVersion() {
    return InShopState(version+1, this.hello);
  }
}

class ErrorShopState extends ShopState {
  final String errorMessage;

  ErrorShopState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorShopState';

  @override
  ErrorShopState getStateCopy() {
    return ErrorShopState(this.version, this.errorMessage);
  }

  @override
  ErrorShopState getNewVersion() {
    return ErrorShopState(version+1, this.errorMessage);
  }
}

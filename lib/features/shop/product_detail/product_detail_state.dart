import 'package:equatable/equatable.dart';
import 'package:wmn_plus/features/shop/product_detail/index.dart';

abstract class ProductDetailState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  ProductDetailState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ProductDetailState getStateCopy();

  ProductDetailState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnProductDetailState extends ProductDetailState {

  UnProductDetailState(int version) : super(version);

  @override
  String toString() => 'UnProductDetailState';

  @override
  UnProductDetailState getStateCopy() {
    return UnProductDetailState(0);
  }

  @override
  UnProductDetailState getNewVersion() {
    return UnProductDetailState(version+1);
  }
}

/// Initialized
class InProductDetailState extends ProductDetailState {
  final ProductResponse hello;

  InProductDetailState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InProductDetailState $hello';

  @override
  InProductDetailState getStateCopy() {
    return InProductDetailState(this.version, this.hello);
  }

  @override
  InProductDetailState getNewVersion() {
    return InProductDetailState(version+1, this.hello);
  }
}

class ErrorProductDetailState extends ProductDetailState {
  final String errorMessage;

  ErrorProductDetailState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorProductDetailState';

  @override
  ErrorProductDetailState getStateCopy() {
    return ErrorProductDetailState(this.version, this.errorMessage);
  }

  @override
  ErrorProductDetailState getNewVersion() {
    return ErrorProductDetailState(version+1, this.errorMessage);
  }
}

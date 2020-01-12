import 'package:equatable/equatable.dart';
import 'package:wmn_plus/features/shop/sub_category_products/sub_category_products_model.dart';

abstract class SubCategoryProductsState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  SubCategoryProductsState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  SubCategoryProductsState getStateCopy();

  SubCategoryProductsState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnSubCategoryProductsState extends SubCategoryProductsState {

  UnSubCategoryProductsState(int version) : super(version);

  @override
  String toString() => 'UnSubCategoryProductsState';

  @override
  UnSubCategoryProductsState getStateCopy() {
    return UnSubCategoryProductsState(0);
  }

  @override
  UnSubCategoryProductsState getNewVersion() {
    return UnSubCategoryProductsState(version+1);
  }
}

/// Initialized
class InSubCategoryProductsState extends SubCategoryProductsState {
  final ProductList hello;

  InSubCategoryProductsState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InSubCategoryProductsState $hello';

  @override
  InSubCategoryProductsState getStateCopy() {
    return InSubCategoryProductsState(this.version, this.hello);
  }

  @override
  InSubCategoryProductsState getNewVersion() {
    return InSubCategoryProductsState(version+1, this.hello);
  }
}

class ErrorSubCategoryProductsState extends SubCategoryProductsState {
  final String errorMessage;

  ErrorSubCategoryProductsState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorSubCategoryProductsState';

  @override
  ErrorSubCategoryProductsState getStateCopy() {
    return ErrorSubCategoryProductsState(this.version, this.errorMessage);
  }

  @override
  ErrorSubCategoryProductsState getNewVersion() {
    return ErrorSubCategoryProductsState(version+1, this.errorMessage);
  }
}

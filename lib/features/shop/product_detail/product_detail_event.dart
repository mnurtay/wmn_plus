import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/shop/product_detail/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductDetailEvent {
  Future<ProductDetailState> applyAsync(
      {ProductDetailState currentState, ProductDetailBloc bloc});
  final ProductDetailRepository _productDetailRepository = ProductDetailRepository();
}

class UnProductDetailEvent extends ProductDetailEvent {
  @override
  Future<ProductDetailState> applyAsync({ProductDetailState currentState, ProductDetailBloc bloc}) async {
    return UnProductDetailState(0);
  }
}

class LoadProductDetailEvent extends ProductDetailEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadProductDetailEvent';

  LoadProductDetailEvent(this.isError);

  @override
  Future<ProductDetailState> applyAsync(
      {ProductDetailState currentState, ProductDetailBloc bloc}) async {
    try {
      if (currentState is InProductDetailState) {
        return currentState.getNewVersion();
      }
      await Future.delayed(Duration(seconds: 2));
      this._productDetailRepository.test(this.isError);
      return InProductDetailState(0, 'Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadProductDetailEvent', error: _, stackTrace: stackTrace);
      return ErrorProductDetailState(0, _?.toString());
    }
  }
}

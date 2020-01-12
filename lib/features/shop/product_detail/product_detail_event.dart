import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/shop/product_detail/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductDetailEvent {
  Future<ProductDetailState> applyAsync(
      {ProductDetailState currentState, ProductDetailBloc bloc});
  final ProductDetailRepository _productDetailRepository =
      ProductDetailRepository();
}

class UnProductDetailEvent extends ProductDetailEvent {
  @override
  Future<ProductDetailState> applyAsync(
      {ProductDetailState currentState, ProductDetailBloc bloc}) async {
    return UnProductDetailState(0);
  }
}

class LoadProductDetailEvent extends ProductDetailEvent {
  final int cat;
  final int sub;
  final int id;

  @override
  String toString() => 'LoadProductDetailEvent';

  LoadProductDetailEvent(this.cat, this.sub, this.id);

  @override
  Future<ProductDetailState> applyAsync(
      {ProductDetailState currentState, ProductDetailBloc bloc}) async {
    try {
      ProductResponse productResponse =
          await _productDetailRepository.getProductDetails(cat, sub, id);
      return InProductDetailState(0, productResponse);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadProductDetailEvent', error: _, stackTrace: stackTrace);
      return ErrorProductDetailState(0, _?.toString());
    }
  }
}

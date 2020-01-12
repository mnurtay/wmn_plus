import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/shop/buy_product/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BuyProductEvent {
  Future<BuyProductState> applyAsync(
      {BuyProductState currentState, BuyProductBloc bloc});
  final BuyProductRepository _buyProductRepository = BuyProductRepository();
}

class UnBuyProductEvent extends BuyProductEvent {
  @override
  Future<BuyProductState> applyAsync(
      {BuyProductState currentState, BuyProductBloc bloc}) async {
    return UnBuyProductState(0);
  }
}

class LoadBuyProductEvent extends BuyProductEvent {
  final bool isError;
  @override
  String toString() => 'LoadBuyProductEvent';

  LoadBuyProductEvent(this.isError);

  @override
  Future<BuyProductState> applyAsync(
      {BuyProductState currentState, BuyProductBloc bloc}) async {
    try {
      return InBuyProductState(0, 'Hello world');
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadBuyProductEvent', error: _, stackTrace: stackTrace);
      return ErrorBuyProductState(0, _?.toString());
    }
  }
}

class CompleteBuyProductEvent extends BuyProductEvent {
  @override
  String toString() => 'LoadBuyProductEvent';
  BuyProduct _productInfo;
  CompleteBuyProductEvent(this._productInfo);

  @override
  Future<BuyProductState> applyAsync(
      {BuyProductState currentState, BuyProductBloc bloc}) async {
    try {
      ResponseJson responseJson =
          await _buyProductRepository.getProductDetails(this._productInfo);
      return CompleteBuyProductState(_productInfo);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadBuyProductEvent', error: _, stackTrace: stackTrace);
      return ErrorBuyProductState(0, _?.toString());
    }
  }
}

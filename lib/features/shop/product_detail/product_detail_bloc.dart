import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/shop/product_detail/index.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  // todo: check singleton for logic in project
  static final ProductDetailBloc _productDetailBlocSingleton = ProductDetailBloc._internal();
  factory ProductDetailBloc() {
    return _productDetailBlocSingleton;
  }
  ProductDetailBloc._internal();
  
  @override
  Future<void> close() async{
    // dispose objects
    await super.close();
  }

  @override
  ProductDetailState get initialState => UnProductDetailState(0);

  @override
  Stream<ProductDetailState> mapEventToState(
    ProductDetailEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ProductDetailBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}

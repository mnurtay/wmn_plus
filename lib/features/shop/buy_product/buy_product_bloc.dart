import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/shop/buy_product/index.dart';

class BuyProductBloc extends Bloc<BuyProductEvent, BuyProductState> {
  // todo: check singleton for logic in project
  static final BuyProductBloc _buyProductBlocSingleton = BuyProductBloc._internal();
  factory BuyProductBloc() {
    return _buyProductBlocSingleton;
  }
  BuyProductBloc._internal();
  
  @override
  Future<void> close() async{
    // dispose objects
    await super.close();
  }

  @override
  BuyProductState get initialState => UnBuyProductState(0);

  @override
  Stream<BuyProductState> mapEventToState(
    BuyProductEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'BuyProductBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}

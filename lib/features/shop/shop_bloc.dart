import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/shop/index.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  // todo: check singleton for logic in project
  static final ShopBloc _shopBlocSingleton = ShopBloc._internal();
  factory ShopBloc() {
    return _shopBlocSingleton;
  }
  ShopBloc._internal();
  
  @override
  Future<void> close() async{
    // dispose objects
    super.close();
  }

  ShopState get initialState => UnShopState(0);

  @override
  Stream<ShopState> mapEventToState(
    ShopEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ShopBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}

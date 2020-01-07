import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/shop/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ShopEvent {
  Future<ShopState> applyAsync({ShopState currentState, ShopBloc bloc});
  final ShopRepository _shopRepository = ShopRepository();
}

class UnShopEvent extends ShopEvent {
  @override
  Future<ShopState> applyAsync({ShopState currentState, ShopBloc bloc}) async {
    return UnShopState(0);
  }
}

class LoadShopEvent extends ShopEvent {
  final bool isError;
  @override
  String toString() => 'LoadShopEvent';

  LoadShopEvent(this.isError);

  @override
  Future<ShopState> applyAsync({ShopState currentState, ShopBloc bloc}) async {
    try {
      Shop shop = await _shopRepository.getShopPage();
      return InShopState(0, shop);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadShopEvent', error: _, stackTrace: stackTrace);
      return ErrorShopState(0, _?.toString());
    }
  }
}

import 'dart:async';
import 'package:wmn_plus/features/discounts/discount_detail/index.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

@immutable
abstract class DiscountDetailEvent {
  Future<DiscountDetailState> applyAsync(
      {DiscountDetailState currentState, DiscountDetailBloc bloc});
  final DiscountDetailRepository _discountDetailRepository =
      DiscountDetailRepository();
}

class UnDiscountDetailEvent extends DiscountDetailEvent {
  @override
  Future<DiscountDetailState> applyAsync(
      {DiscountDetailState currentState, DiscountDetailBloc bloc}) async {
    return UnDiscountDetailState(0);
  }
}

class LoadDiscountDetailEvent extends DiscountDetailEvent {
  final Map<String, dynamic> route;
  @override
  String toString() => 'LoadDiscountDetailEvent';

  LoadDiscountDetailEvent(this.route);

  @override
  Future<DiscountDetailState> applyAsync(
      {DiscountDetailState currentState, DiscountDetailBloc bloc}) async {
    try {
      if (currentState is InDiscountDetailState) {
        return currentState.getNewVersion();
      }

      Discountdetail discountdetail = await this
          ._discountDetailRepository
          .fetchDiscountDetail(route["catId"], route["disId"]);

      return InDiscountDetailState(0, discountdetail);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadDiscountDetailEvent', error: _, stackTrace: stackTrace);
      return ErrorDiscountDetailState(0, _?.toString());
    }
  }
}

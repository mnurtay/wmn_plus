import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/discounts/index.dart';
import 'dart:developer' as developer;

class DiscountsBloc extends Bloc<DiscountsEvent, DiscountsState> {
  // todo: check singleton for logic in project
  static final DiscountsBloc _discountsBlocSingleton = DiscountsBloc._internal();
  factory DiscountsBloc() {
    return _discountsBlocSingleton;
  }
  DiscountsBloc._internal();
  
  @override
  dispose(){
    // _discountsBlocSingleton.dispose();
    super.close();
  }

  DiscountsState get initialState => UnDiscountsState(0);

  @override
  Stream<DiscountsState> mapEventToState(
    DiscountsEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'DiscountsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}

import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/shop/category_detail/index.dart';

class CategoryDetailBloc extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  // todo: check singleton for logic in project
  static final CategoryDetailBloc _categoryDetailBlocSingleton = CategoryDetailBloc._internal();
  factory CategoryDetailBloc() {
    return _categoryDetailBlocSingleton;
  }
  CategoryDetailBloc._internal();
  
  @override
  Future<void> close() async{
    // dispose objects
    await super.close();
  }

  @override
  CategoryDetailState get initialState => UnCategoryDetailState(0);

  @override
  Stream<CategoryDetailState> mapEventToState(
    CategoryDetailEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'CategoryDetailBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}

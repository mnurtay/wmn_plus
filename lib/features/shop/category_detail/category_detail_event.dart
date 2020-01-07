import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/shop/category_detail/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryDetailEvent {
  Future<CategoryDetailState> applyAsync(
      {CategoryDetailState currentState, CategoryDetailBloc bloc});
  final CategoryDetailRepository _categoryDetailRepository = CategoryDetailRepository();
}

class UnCategoryDetailEvent extends CategoryDetailEvent {
  @override
  Future<CategoryDetailState> applyAsync({CategoryDetailState currentState, CategoryDetailBloc bloc}) async {
    return UnCategoryDetailState(0);
  }
}

class LoadCategoryDetailEvent extends CategoryDetailEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadCategoryDetailEvent';

  LoadCategoryDetailEvent(this.isError);

  @override
  Future<CategoryDetailState> applyAsync(
      {CategoryDetailState currentState, CategoryDetailBloc bloc}) async {
    try {
      if (currentState is InCategoryDetailState) {
        return currentState.getNewVersion();
      }
      // await Future.delayed(Duration(seconds: 2));
      this._categoryDetailRepository.test(this.isError);
      return InCategoryDetailState(0, 'Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadCategoryDetailEvent', error: _, stackTrace: stackTrace);
      return ErrorCategoryDetailState(0, _?.toString());
    }
  }
}

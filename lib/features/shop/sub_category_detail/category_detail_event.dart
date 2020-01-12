import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/shop/sub_category_detail/index.dart';
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
   
  final int id;
  @override
  String toString() => 'LoadCategoryDetailEvent';

  LoadCategoryDetailEvent(this.id);

  @override
  Future<CategoryDetailState> applyAsync(
      {CategoryDetailState currentState, CategoryDetailBloc bloc}) async {
    try {
      SubCategoryList subCategoryList = await _categoryDetailRepository.getSubCategoryPage(id);
      return InCategoryDetailState(0, subCategoryList);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadCategoryDetailEvent', error: _, stackTrace: stackTrace);
      return ErrorCategoryDetailState(0, _?.toString());
    }
  }
}

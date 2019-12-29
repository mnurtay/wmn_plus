import 'dart:async';
import 'package:wmn_plus/features/news/index.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

@immutable
abstract class NewsEvent {
  Future<NewsState> applyAsync({NewsState currentState, NewsBloc bloc});
  final NewsRepository _newsRepository = NewsRepository();
}

class UnNewsEvent extends NewsEvent {
  @override
  Future<NewsState> applyAsync({NewsState currentState, NewsBloc bloc}) async {
    return UnNewsState(0);
  }
}

class LoadNewsEvent extends NewsEvent {
  @override
  String toString() => 'LoadNewsEvent';
  final int category;
  LoadNewsEvent({@required this.category});

  @override
  Future<NewsState> applyAsync({NewsState currentState, NewsBloc bloc}) async {
    try {
      print(category);
      var newsList = await NewsRepository().getNewsList(0, category);
      if (newsList == null) return InNewsState(0, []);
      return InNewsState(0, newsList);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadNewsEvent', error: _, stackTrace: stackTrace);
      return ErrorNewsState(0, _?.toString());
    }
  }
}

class CategoryChangedNewsEvent extends NewsEvent {
  final int category;

  @override
  String toString() => 'LoadNewsEvent';

  CategoryChangedNewsEvent({@required this.category});

  @override
  Future<NewsState> applyAsync({NewsState currentState, NewsBloc bloc}) async {
    try {
      if (category == 1) return CategoryOneNewsState(0, category);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadNewsEvent', error: _, stackTrace: stackTrace);
      return ErrorNewsState(0, _?.toString());
    }
  }
}

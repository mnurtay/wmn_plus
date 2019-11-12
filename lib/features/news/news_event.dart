import 'dart:async';
import 'package:wmn_plus/features/news/index.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

@immutable
abstract class NewsEvent {
  Future<NewsState> applyAsync(
      {NewsState currentState, NewsBloc bloc});
  final NewsRepository _newsRepository = NewsRepository();
}

class UnNewsEvent extends NewsEvent {
  @override
  Future<NewsState> applyAsync({NewsState currentState, NewsBloc bloc}) async {
    return UnNewsState(0);
  }
}

class LoadNewsEvent extends NewsEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadNewsEvent';

  LoadNewsEvent(this.isError);

  @override
  Future<NewsState> applyAsync(
      {NewsState currentState, NewsBloc bloc}) async {
    try {
      if (currentState is InNewsState) {
        return currentState.getNewVersion();
      }
      await Future.delayed(Duration(seconds: 3));
      var news = this._newsRepository.test(this.isError);
      return InNewsState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadNewsEvent', error: _, stackTrace: stackTrace);
      return ErrorNewsState(0, _?.toString());
    }
  }
}

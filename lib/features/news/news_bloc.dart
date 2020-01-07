import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/news/index.dart';
import 'dart:developer' as developer;

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  // todo: check singleton for logic in project
  static final NewsBloc _newsBlocSingleton = NewsBloc._internal();
  factory NewsBloc() {
    return _newsBlocSingleton;
  }
  NewsBloc._internal();

  NewsState get initialState => UnNewsState(0);

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'NewsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}

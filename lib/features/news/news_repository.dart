import 'package:wmn_plus/features/news/index.dart';

class NewsRepository {
  final NewsProvider _newsProvider = NewsProvider();

  NewsRepository();

  void test(bool isError) {
    this._newsProvider.test(isError);
  }
}
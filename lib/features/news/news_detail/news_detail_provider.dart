import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wmn_plus/features/news/news_detail/news_detail_model.dart';

class NewsDetailProvider {
  Future<void> loadAsync(String token) async {
    /// write from keystore/keychain
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> saveAsync(String token) async {
    /// write from keystore/keychain
    await Future.delayed(Duration(seconds: 2));
  }

  Future<NewsDetail> getNewsDetail(String id) async {
    Response response;
    try {
      response = await get('http://194.146.43.98:4000/api/v1/patient/newsDetail/$id',
          headers: {
            "Content-Type": "application/json",
            "Authorization": "wmn538179",
          });
      String body = utf8.decode(response.bodyBytes);
      Map newsObject = json.decode(body);
      var newsList = NewsDetail.fromJson(newsObject);
      print(body);
      return newsList;
    } catch (error) {
      print(error);
      throw (error.toString());
    }
  }

  void test(bool isError) {
    if (isError == true) {
      throw Exception("manual error");
    }
  }
}
